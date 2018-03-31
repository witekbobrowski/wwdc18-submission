//
//  InputResponder.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum InputType {
    case menu
    case enter
    case next
    case previous
    case play
    case scroll(ScrollWheelStateChange)
}

protocol InputResponder: class {
    func respond(toInputType type: InputType)
}
