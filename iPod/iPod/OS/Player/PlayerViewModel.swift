//
//  PlayerViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol PlayerViewModel {
    var position: String { get }
    var song: String { get }
    var author: String { get }
    var album: String { get }
    var volume: Float { get }
    var currentTime: String { get }
    var duration: String { get }
}

class PlayerViewModelImplementation: PlayerViewModel {

    private let playerService: PlayerService
    private let songs: [Song]

    var position: String {
        return "1 of 1"
    }
    var song: String {
        return playerService.currentSong?.title ?? ""
    }
    var author: String {
        return playerService.currentSong?.artists.reduce("") { $0 + $1.name + " " } ?? ""
    }
    var album: String {
        return playerService.currentSong?.album?.title ?? ""
    }
    var volume: Float {
        return playerService.volume
    }
    var currentTime: String {
        return playerService.currentTime.description
    }
    var duration: String {
        return playerService.duration.description
    }

    init(playerService: PlayerService, songs: [Song]) {
        self.playerService = playerService
        self.songs = songs
    }

}
