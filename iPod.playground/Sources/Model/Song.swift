//
//  Song.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

struct Song {
    var title: String
    var artist: Artist
    var album: Album?
    var genre: String?
    var url: URL

    init(title: String,
         artist: Artist,
         album: Album?,
         genre: String?,
         url: URL) {
        self.title = title
        self.artist = artist
        self.album = album
        self.genre = genre
        self.url = url
    }
}
