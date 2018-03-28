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
    case artists = "Artists"
    case songs = "Songs"
    case settings = "Settings"
    case about = "About"
    case nowPlaying = "Now Playing"
}

protocol MainMenuViewModelDelegate: class {
    func mainMenuViewModel(_ mainMenuViewModel: MainMenuViewModel, didSelectItem item: MainMenuItem)
}

class MainMenuViewModel: MenuViewModel {

    private(set) var items: [MainMenuItem]
    weak var delegate: MainMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [MainMenuItem]) {
        self.items = items
    }

    func numberOfSections() -> Int {
        return items.isEmpty ? 0 : 1
    }

    func numberOfRows(inSection section: Int) -> Int {
        return section == 0 ? items.count : 0
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        return MenuCellViewModelImplementation(title: items[row].rawValue)
    }

    func selectCell(inRow row: Int) {
        delegate?.mainMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() { return } // Cant go back from MainMenu

}
