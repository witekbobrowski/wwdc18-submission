//
//  PlayerViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum PlayerViewModelType {
    case songs
    case playlist(Playlist)
    case album(Album)
    case artist(Artist)
    case nowPlaying
}

protocol PlayerViewModelDelegate: class {
    func playerViewModelDidClickGoBack(_ playerViewModel: PlayerViewModel)
}

protocol PlayerViewModel {
    var delegate: PlayerViewModelDelegate? { get set }
    var type: PlayerViewModelType { get }
    var position: String { get }
    var song: String { get }
    var author: String { get }
    var album: String { get }
    var volume: Float { get }
    var currentTime: String { get }
    var duration: String { get }
    func goBackAction()
    func enterAction()
}

class PlayerViewModelImplementation: PlayerViewModel {

    private let playerService: PlayerService
    private let playlist: [Song]

    weak var delegate: PlayerViewModelDelegate?
    let type: PlayerViewModelType
    var position: String {
        guard let song = playerService.currentSong, let index = playlist.index(where: { $0.url == song.url }) else { return "" }
        return "\(index + 1) of \(playlist.count)"
    }
    var song: String {
        return playerService.currentSong?.title ?? ""
    }
    var author: String {
        return playerService.currentSong?.artist.name ?? ""
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

    init(playerService: PlayerService, song: Song?, playlist: [Song], type: PlayerViewModelType) {
        self.playerService = playerService
        self.playlist = playlist
        self.type = type
        guard let song = song else { return }
        playerService.play(song, fromPlaylist: playlist)
    }

    func goBackAction() {
        delegate?.playerViewModelDidClickGoBack(self)
    }

    func enterAction() {
        if playerService.isPlaying {
            playerService.pause()
        } else {
            playerService.resume()
        }
    }

}
