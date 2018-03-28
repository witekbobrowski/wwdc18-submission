//
//  MainMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum MainMenuItem: String {
    case playlists = "Playlists"
    case browse = "Browse"
    case extras = "Extras"
    case settings = "Settings"
    case about = "About"
}

protocol MainMenuViewModelDelegate: class {
    func mainMenuViewModel(_ mainMenuViewModel: MainMenuViewModel, didSelectItem item: MainMenuItem)
}

class MainMenuViewModel: MenuViewModel {

    let items: [MainMenuItem] = [.playlists, .browse, .extras, .settings, .about]

    weak var delegate: MainMenuViewModelDelegate?

    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    func numberOfRows() -> Int {
        return items.count
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        return MenuCellViewModelImplementation(title: items[row].rawValue)
    }

    func selectCell(inRow row: Int) {
        delegate?.mainMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        return // Cant go back from MainMenu
    }

}
