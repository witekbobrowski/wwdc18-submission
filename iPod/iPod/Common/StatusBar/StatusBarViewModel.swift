//
//  StatusBarViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol StatusBarViewModel {
    var title: String { get }
    var isPlaying: Bool { get }
    var isCharging: Bool { get }
}

class StatusBarViewModelImplementation: StatusBarViewModel {

    let title: String
    let isPlaying: Bool
    let isCharging: Bool

    init(title: String, isPlaying: Bool, isCharging: Bool) {
        self.title = title
        self.isPlaying = isPlaying
        self.isCharging = isCharging
    }

}
