//
//  MainMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum MainMenuItem {
    case playlists
    case artists
    case songs([Song])
    case settings
    case about
    case nowPlaying([Song])
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
        switch items[row] {
        case .playlists:
            return MenuCellViewModelImplementation(title: Strings.playlists)
        case .artists:
            return MenuCellViewModelImplementation(title: Strings.artists)
        case .songs:
            return MenuCellViewModelImplementation(title: Strings.songs)
        case .settings:
            return MenuCellViewModelImplementation(title: Strings.settings)
        case .about:
            return MenuCellViewModelImplementation(title: Strings.about)
        case .nowPlaying:
            return MenuCellViewModelImplementation(title: Strings.nowPlaying)
        }
    }

    func selectCell(inRow row: Int) {
        delegate?.mainMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() { return } // Cant go back from MainMenu

}
