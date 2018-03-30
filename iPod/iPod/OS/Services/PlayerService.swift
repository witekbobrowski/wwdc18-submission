//
//  PlayerService.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerServiceDelegate: class {
    func playerService(_ playerService: PlayerService, didStartPlaying song: Song)
    func playerService(_ playerService: PlayerService, didFinishPlaying song: Song)
    func playerService(_ playerService: PlayerService, didPause song: Song)
    func playerService(_ playerService: PlayerService, didPassPlaybackTime time: TimeInterval)
    func playerService(_ playerService: PlayerService, didFastForwardToTime time: TimeInterval)
    func playerService(_ playerService: PlayerService, didRewindToTime time: TimeInterval)
}

protocol PlayerService {
    var delegate: PlayerServiceDelegate? { get set }
    var isPlaying: Bool { get }
    var volume: Float { get }
    var currentSong: Song? { get }
    var currentTime: TimeInterval { get }
    var duration: TimeInterval { get }
    func play(_ song: Song, fromPlaylist playlist: [Song])
    func resume()
    func next()
    func previous()
    func fastForward()
    func rewind()
    func pause()
    func stop()
    func changeVolume(_ volume: Float)
}

class PlayerServiceImplementation: PlayerService {

    private enum Constants {
        static let rewindTimeInterval: TimeInterval = 10
        static let fastForwardTimeInterval: TimeInterval = 10
    }

    private var player: AVPlayer = AVPlayer()
    private var playlist: [Song] = []
    private var currentIndex: Int?

    weak var delegate: PlayerServiceDelegate?

    var currentSong: Song? {
        guard let index = currentIndex, playlist.indices.contains(index) else {
            return nil
        }
        return playlist[index]
    }
    var isPlaying: Bool {
        return player.timeControlStatus == .playing
    }
    var volume: Float {
        return  player.volume
    }
    var currentTime: TimeInterval {
        return CMTimeGetSeconds(player.currentTime())
    }
    var duration: TimeInterval {
        guard let time = player.currentItem?.duration else { return 0 }
        return CMTimeGetSeconds(time)
    }

    init() {
        self.setupObservers()
    }

    func play(_ song: Song, fromPlaylist playlist: [Song]) {
        self.playlist = playlist.isEmpty ? [song] : playlist
        currentIndex = playlist.index { $0.url == song.url }
        play(song)
    }

    func resume() {
        player.play()
    }

    func next() {
        guard let index = currentIndex else { return }
        let nextIndex = index + 1
        if nextIndex < playlist.count {
            play(playlist[nextIndex])
            currentIndex = nextIndex
        } else {
            stop()
        }
    }

    func previous() {
        guard let index = currentIndex else { return }
        let previousIndex = index - 1
        if 0 <= previousIndex && previousIndex < playlist.count {
            play(playlist[previousIndex])
            currentIndex = previousIndex
        } else {
            play(playlist[index])
        }
    }

    func fastForward() {
        let seconds = currentTime + Constants.fastForwardTimeInterval
        player.seek(to: CMTime(seconds: duration < seconds ? duration : seconds, preferredTimescale: 1))
        delegate?.playerService(self, didFastForwardToTime: currentTime)
    }

    func rewind() {
        let seconds = currentTime - Constants.fastForwardTimeInterval
        player.seek(to: CMTime(seconds: seconds < 0 ? 0 : seconds, preferredTimescale: 1))
        delegate?.playerService(self, didRewindToTime: currentTime)
    }

    func pause() {
        player.pause()
        guard let song = currentSong else { return }
        delegate?.playerService(self, didPause: song)
    }

    func stop() {
        player.replaceCurrentItem(with: nil)
    }

    func changeVolume(_ volume: Float) {
        player.volume = volume
    }

}

extension PlayerServiceImplementation {

    private func play(_ song: Song) {
        let playerItem = AVPlayerItem(url: song.url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        delegate?.playerService(self, didStartPlaying: song)
    }

    private func setupObservers() {
        let interval = CMTime(seconds: 1, preferredTimescale: 1)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let `self` = self else { return }
            let seconds = CMTimeGetSeconds(time)
            self.delegate?.playerService(self, didPassPlaybackTime: seconds)
        }
    }

}
