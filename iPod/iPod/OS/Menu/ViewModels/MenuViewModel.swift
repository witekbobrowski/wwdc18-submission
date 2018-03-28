//
//  MenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol MenuViewModel {
    var rowInitallyHighlighed: Int? { get }
    func numberOfSections() -> Int
    func numberOfRows(inSection section: Int) -> Int
    func viewModelForCell(inRow row: Int) -> MenuCellViewModel
    func selectCell(inRow row: Int)
    func goBack()
}
