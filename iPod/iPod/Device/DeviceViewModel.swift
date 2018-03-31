//
//  DeviceViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol DeviceViewModel {
    var operatingSystemCoordinatorModel: OperatingSystemCoordinatorModel { get }
    var controlPanelViewModel: ControlPanelViewModel { get }
    var inputResponder: InputResponder? { get set }
}

class DeviceViewModelImplementation: DeviceViewModel {

    private(set) var operatingSystemCoordinatorModel: OperatingSystemCoordinatorModel
    private(set) var controlPanelViewModel: ControlPanelViewModel

    weak var inputResponder: InputResponder?

    init(operatingSystemCoordinatorModel: OperatingSystemCoordinatorModel,
         controlPanelViewModel: ControlPanelViewModel) {
        self.operatingSystemCoordinatorModel = operatingSystemCoordinatorModel
        self.controlPanelViewModel = controlPanelViewModel
        self.controlPanelViewModel.delegate = self
    }

}

extension DeviceViewModelImplementation: ControlPanelDelegate {

    func controlPanelViewModelDidRecievedMenuClick(_ controlPanelViewModel: ControlPanelViewModel) {
        inputResponder?.respond(toInputType: .menu)
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
