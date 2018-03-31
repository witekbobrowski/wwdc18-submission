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
    func playerViewModel(_ playerViewModel: PlayerViewModel, didStartPlayingSong song: Song, fromPlaylist playlst: [Song])
    func playerViewModelDidPausePlaying(_ playerViewModel: PlayerViewModel)
    func playerViewModelDidStopPlaying(_ playerViewModel: PlayerViewModel)
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
    func nextAction()
    func previousAction()
    func volumeUpAction()
    func volumeDownAction()
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

    func nextAction() {
        playerService.next()
    }

    func previousAction() {
        playerService.previous()
    }

    func volumeUpAction() {
        playerService.changeVolume(playerService.volume + 0.1)
    }

    func volumeDownAction() {
        playerService.changeVolume(playerService.volume - 0.1)
    }

}

extension PlayerViewModelImplementation: PlayerServiceDelegate {

    func playerService(_ playerService: PlayerService, didStartPlaying song: Song) {
        delegate?.playerViewModel(self, didStartPlayingSong: song, fromPlaylist: playlist)
    }

    func playerService(_ playerService: PlayerService, didFinishPlaying song: Song) {
        delegate?.playerViewModelDidStopPlaying(self)
    }

    func playerService(_ playerService: PlayerService, didPause song: Song) {
        delegate?.playerViewModelDidPausePlaying(self)
    }

    func playerService(_ playerService: PlayerService, didPassPlaybackTime time: TimeInterval) {

    }

    func playerService(_ playerService: PlayerService, didFastForwardToTime time: TimeInterval) {

    }

    func playerService(_ playerService: PlayerService, didRewindToTime time: TimeInterval) {

    }

}
