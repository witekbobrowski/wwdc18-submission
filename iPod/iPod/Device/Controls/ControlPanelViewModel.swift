//
//  ControlPanelViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ControlPanelDelegate: class {
    func controlPanelViewModelDidRecievedMenuClick(_ controlPanelViewModel: ControlPanelViewModel)
    func controlPanelViewModelDidRecievedPlayClick(_ controlPanelViewModel: ControlPanelViewModel)
    func controlPanelViewModelDidRecievedNextClick(_ controlPanelViewModel: ControlPanelViewModel)
    func controlPanelViewModelDidRecievedPreviousClick(_ controlPanelViewModel: ControlPanelViewModel)
    func controlPanelViewModelDidRecievedEnterClick(_ controlPanelViewModel: ControlPanelViewModel)
    func controlPanelViewModel(_ controlPanelViewModel: ControlPanelViewModel, didRecievedScrollState state: ScrollWheelStateChange)
}

protocol ControlPanelViewModel {
    var delegate: ControlPanelDelegate? { get set }
    var menuButtonTitle: String { get }
    func menuAction()
    func playAction()
    func nextAction()
    func previousAction()
    func enterAction()
    func scrollAction(withState state: ScrollWheelStateChange)
}

class ControlPanelViewModelImplementation: ControlPanelViewModel {

    weak var delegate: ControlPanelDelegate?
    var menuButtonTitle: String { return "menu" }

    func menuAction() {
        delegate?.controlPanelViewModelDidRecievedMenuClick(self)
    }

    func playAction() {
        delegate?.controlPanelViewModelDidRecievedPlayClick(self)
    }

    func nextAction() {
        delegate?.controlPanelViewModelDidRecievedNextClick(self)
    }

    func previousAction() {
        delegate?.controlPanelViewModelDidRecievedPreviousClick(self)
    }

    func enterAction() {
        delegate?.controlPanelViewModelDidRecievedEnterClick(self)
    }

    func scrollAction(withState state: ScrollWheelStateChange) {
        delegate?.controlPanelViewModel(self, didRecievedScrollState: state)
    }

}
