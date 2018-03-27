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

    init(operatingSystemViewModel: OperatingSystemViewModel,
         controlPanelViewModel: ControlPanelViewModel) {
        self.operatingSystemViewModel = operatingSystemViewModel
        self.controlPanelViewModel = controlPanelViewModel
        self.controlPanelViewModel.delegate = self
    }

}

extension DeviceViewModelImplementation: ControlPanelDelegate {}
