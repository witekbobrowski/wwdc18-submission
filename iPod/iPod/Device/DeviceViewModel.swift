//
//  DeviceViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol DeviceViewModel {
    var operatingSystemViewModel: OperatingSystemViewModel { get }
    var controlPanelViewModel: ControlPanelViewModel { get }
}

class DeviceViewModelImplementation: DeviceViewModel {

    private(set) var operatingSystemViewModel: OperatingSystemViewModel
    private(set) var controlPanelViewModel: ControlPanelViewModel

    private weak var inputResponder: InputResponder?

    init(operatingSystemViewModel: OperatingSystemViewModel,
         controlPanelViewModel: ControlPanelViewModel) {
        self.operatingSystemViewModel = operatingSystemViewModel
        self.controlPanelViewModel = controlPanelViewModel
        self.controlPanelViewModel.delegate = self
        self.inputResponder = operatingSystemViewModel
    }

}

extension DeviceViewModelImplementation: ControlPanelDelegate {

    func controlPanelViewModelDidRecievedMenuClick(_ controlPanelViewModel: ControlPanelViewModel) {
        inputResponder?.respond(toInputType: .manu)
    }

    func controlPanelViewModelDidRecievedPlayClick(_ controlPanelViewModel: ControlPanelViewModel) {
        inputResponder?.respond(toInputType: .play)
    }

    func controlPanelViewModelDidRecievedNextClick(_ controlPanelViewModel: ControlPanelViewModel) {
        inputResponder?.respond(toInputType: .next)
    }

    func controlPanelViewModelDidRecievedPreviousClick(_ controlPanelViewModel: ControlPanelViewModel) {
        inputResponder?.respond(toInputType: .previous)
    }

    func controlPanelViewModelDidRecievedEnterClick(_ controlPanelViewModel: ControlPanelViewModel) {
        inputResponder?.respond(toInputType: .enter)
    }

    func controlPanelViewModel(_ controlPanelViewModel: ControlPanelViewModel, didRecievedScrollState state: ScrollWheelStateChange) {
        inputResponder?.respond(toInputType: .scroll(state))
    }

}
