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

    var songs: [Song] = []
    var artists: [Artist] = []
    var playlists: [Playlist] = []
    var favourites: [Song] = []

    init(storageService: StorageService) {
        self.storageService = storageService
        self.evaluateAssets()
    }

    func albumsOfArtist(_ artist: Artist?) -> [Album] {
        return []
    }

}

extension LibraryServiceImplementation {

    private func evaluateAssets() {
        guard let urls = storageService.items else { return }
        for url in urls {
            let asset = AVAsset(url: url)
        }
    }

}
