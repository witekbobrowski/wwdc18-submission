//
//  MenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//
import Foundation

protocol MenuViewModelDelegate: class {
    func menuViewModel(_ menuViewModel: MenuViewModel, didSelectItem: String)
}

protocol MenuViewModel {
    var delegate: MenuViewModelDelegate? { get set }
    func numberOfRows() -> Int
    func viewModelForCell(inRow row: Int) -> String
    func selectCell(inRow row: Int)
}

class MenuViewModelImplementation: MenuViewModel {

    let items: [String]

    weak var delegate: MenuViewModelDelegate?

    init(items: [String]) {
        self.options = items
    }

    func numberOfRows() -> Int {
        return items.count
    }

    func viewModelForCell(inRow row: Int) -> String {
        return items[row]
    }

    func selectCell(inRow row: Int) {
        delegate?.menuViewModel(self, didSelectItem: items[row])
    }

}
