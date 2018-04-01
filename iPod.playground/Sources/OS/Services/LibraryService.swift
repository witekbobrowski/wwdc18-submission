//
//  LibraryService.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import AVFoundation

protocol LibraryService {
    var songs: [Song] { get }
    var artists: [Artist] { get }
    var playlists: [Playlist] { get }
    var favourites: [Song] { get }
    func albumsOfArtist(_ artist: Artist?) -> [Album]
}

class LibraryServiceImplementation: LibraryService {

    private let storageService: StorageService
    private var library: [Song] = []
    private var libraryByArtist: [String:[Song]] = [:]
    private var libraryByAlbum: [String:[Song]] = [:]
    private var libraryByGenre: [String:[Song]] = [:]
    private var albumsByArtist: [String:Set<String>] = [:]
    private var songsByAlbum: [String:[Song]] = [:]

    private(set) lazy var songs: [Song] = { library.sorted { $0.title < $1.title } }()
    private(set) lazy var artists: [Artist] = { libraryByArtist.map { Artist(name: $0.key, albums: []) } }()
    private(set) lazy var playlists: [Playlist] = { libraryByGenre.map { Playlist(title: $0.key, songs: $0.value) } }()
    private(set) lazy var favourites: [Song] = { songs }()

    init(storageService: StorageService) {
        self.storageService = storageService
        self.evaluateAssets()
    }

    func albumsOfArtist(_ artist: Artist?) -> [Album] {
        var albums: [Album] = []
        if let artist = artist {
            albums = albumsByArtist[artist.name]?.map { return Album(title: $0, artist: artist, songs: songsByAlbum[$0] ?? []) } ?? []
        } else {
            albums = libraryByAlbum.map { Album(title: $0.key, artist: nil, songs: $0.value) }
        }
        return albums.sorted { $0.title < $1.title }
    }

}

extension LibraryServiceImplementation {

    private func evaluateAssets() {
        guard let urls = storageService.items else { return }
        var library: [Song] = []
        var libraryByArtist: [String:[Song]] = [:]
        var libraryByGenre: [String:[Song]] = [:]
        var libraryByAlbum: [String:[Song]] = [:]
        var albumsByArtist: [String:Set<String>] = [:]
        var songsByAlbum: [String:[Song]] = [:]
        for url in urls {
            let asset = AVAsset(url: url)
            var title: String = "Unknown"
            var author: String = "Unknown"
            var albumName: String = "Unknown"
            var genre: String = ""
            for metaItem in asset.metadata {
                guard let key = metaItem.commonKey else { continue }
                switch key {
                case AVMetadataKey.commonKeyTitle:
                    if let metaTitle = metaItem.value as? String {
                        title = metaTitle
                    }
                case AVMetadataKey.commonKeyArtist,
                     AVMetadataKey.commonKeyAuthor,
                     AVMetadataKey.commonKeyCreator:
                    if let artist = metaItem.value as? String {
                        author = artist
                    }
                case AVMetadataKey.commonKeyAlbumName:
                    if let metaAlbum = metaItem.value as? String {
                        albumName = metaAlbum
                    }
                case AVMetadataKey.commonKeyType:
                    if let metaGenre = metaItem.value as? String {
                        genre = metaGenre
                    }
                default:
                    continue
                }
            }
            let artist = Artist(name: author, albums: [])
            let album = Album(title: albumName, artist: artist, songs: [])
            let entry = Song(title: title, artist: artist, album: album, genre: genre, url: url)
            library.append(entry)
            libraryByArtist[author, default: []] += [entry]
            libraryByAlbum[albumName, default: []] += [entry]
            libraryByGenre[genre, default: []] += [entry]
            albumsByArtist[author] = albumsByArtist[author, default: []].union([albumName])
            songsByAlbum[albumName, default: []] += [entry]
        }
        self.library = library
        self.libraryByArtist = libraryByArtist
        self.libraryByGenre = libraryByGenre
        self.libraryByAlbum = libraryByAlbum
        self.albumsByArtist = albumsByArtist
        self.songsByAlbum = songsByAlbum
    }

}
