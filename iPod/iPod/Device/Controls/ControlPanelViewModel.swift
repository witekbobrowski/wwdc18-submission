//
//  ControlPanelViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ControlPanelViewModel {
    var menuButtonTitle: String { get }
    func menuButtonDidTap()
    func playPauseButtonDidTap()
    func fastForwardButtonDidTap()
    func rewindButtonDidTap()
}

class ControlPanelViewModelImplementation: ControlPanelViewModel {

    var menuButtonTitle: String { return "menu" }

    func menuButtonDidTap() {
        print("MENU")
    }

    func playPauseButtonDidTap() {
        print("PLAY/PAUSE")
    }

    func fastForwardButtonDidTap() {
        print("FAST FORWARD")
    }

    func rewindButtonDidTap() {
        print("REWIND")
    }

}
