//
//  PlayerService.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol PlayerService {
    var isPlaying: Bool { get }
    func play(_ song: Song)
    func next()
    func previous()
    func fastForward()
    func rewind()
    func pause()
}
