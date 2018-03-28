//
//  LibraryService.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol LibraryService {
    var songs: [Song] { get }
    var artists: [Artist] { get }
    var playlists: [Playlist] { get }
    var favourites: [Song] { get }
    func albumsOfArtist(_ artist: Artist?) -> [Album]
}

class LibraryServiceImplementation: LibraryService {

    var songs: [Song] { return [] }
    var artists: [Artist] { return [] }
    var playlists: [Playlist] { return [] }
    var favourites: [Song] { return [] }

    func albumsOfArtist(_ artist: Artist?) -> [Album] {
        return []
    }

}
