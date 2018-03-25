//
//  MenuCellViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol MenuCellViewModel {
    var title: String { get }
    var disclosure: String { get }
}

class MenuCellViewModelImplementation: MenuCellViewModel {

    let title: String
    var disclosure: String { return ">" }

    init(title: String) {
        self.title = title
    }

}
