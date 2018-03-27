//
//  MenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol MenuViewModelDelegate: class {
    func menuViewModel(_ menuViewModel: MenuViewModel, didSelectItem item: String)
    func menuViewModelDidClickGoBack(_ menuViewModel: MenuViewModel)
}

protocol MenuViewModel {
    var delegate: MenuViewModelDelegate? { get set }
    var rowInitallyHighlighed: Int? { get }
    func numberOfRows() -> Int
    func viewModelForCell(inRow row: Int) -> MenuCellViewModel
    func selectCell(inRow row: Int)
    func goBack()
}

class MenuViewModelImplementation: MenuViewModel {

    let items: [String]

    weak var delegate: MenuViewModelDelegate?

    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [String]) {
        self.items = items
    }

    func numberOfRows() -> Int {
        return items.count
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        return MenuCellViewModelImplementation(title: items[row])
    }

    func selectCell(inRow row: Int) {
        delegate?.menuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        delegate?.menuViewModelDidClickGoBack(self)
    }

}
