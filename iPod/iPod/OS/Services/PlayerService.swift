//
//  PlayerService.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerService {
    var isPlaying: Bool { get }
    func play(_ song: Song, fromPlaylist playlist: [Song])
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

    private let audioPlayer: AVAudioPlayer
    private var playlist: [Song] = []
    private var currentIndex: Int?

    var currentSong: Song? {
        guard let index = currentIndex, playlist.indices.contains(index) else {
            return nil
        }
        return playlist[index]
    }
    var isPlaying: Bool {
        return audioPlayer.isPlaying
    }

    init(audioPlayer: AVAudioPlayer) {
        self.audioPlayer = audioPlayer
    }

    func play(_ song: Song, fromPlaylist playlist: [Song]) {
        self.playlist = playlist.isEmpty ? [song] : playlist
        currentIndex = playlist.index { $0.title == song.title && $0.album?.title == song.album?.title }
        play(song)
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
        audioPlayer.play(atTime: audioPlayer.currentTime - Constants.fastForwardTimeInterval)
    }

    func rewind() {
        audioPlayer.play(atTime: audioPlayer.currentTime - Constants.rewindTimeInterval)
    }

    func pause() {
        audioPlayer.pause()
    }

    func stop() {
        audioPlayer.stop()
    }

    func changeVolume(_ volume: Float) {
        audioPlayer.setVolume(volume, fadeDuration: 0)
    }

}

extension PlayerServiceImplementation {

    private func play(_ song: Song) {
        audioPlayer.play()
    }

}
