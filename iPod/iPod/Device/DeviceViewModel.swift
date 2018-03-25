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

    var operatingSystemViewModel: OperatingSystemViewModel {
        return OperatingSystemViewModelImplementation()
    }

    var controlPanelViewModel: ControlPanelViewModel {
        return ControlPanelViewModelImplementation()
    }

}
