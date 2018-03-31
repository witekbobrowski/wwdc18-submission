//
//  OperatingSystemViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol OperatingSystemViewModel {
    var statusBarTitle: String { get }
}

class OperatingSystemViewModelImplementation: OperatingSystemViewModel {

    var statusBarTitle: String { return Strings.iPod }

}
