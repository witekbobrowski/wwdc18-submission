//
//  PlaylistsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum PlaylistsMenuItem {
    case favourites
    case custom(String)
}

protocol PlaylistsMenuViewModelDelegate: class {
    func playlistsMenuViewModel(_ playlistsMenuViewModel: PlaylistsMenuViewModel, didSelectItem item: PlaylistsMenuItem)
    func playlistsMenuViewModelDidClickGoBack(_ playlistsMenuViewModel: PlaylistsMenuViewModel)
}

class PlaylistsMenuViewModel: MenuViewModel {

    let items: [PlaylistsMenuItem]

    weak var delegate: PlaylistsMenuViewModelDelegate?

    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [PlaylistsMenuItem]) {
        self.items = items
    }

    func numberOfRows() -> Int {
        return items.count
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        switch items[row] {
        case .favourites:
            return MenuCellViewModelImplementation(title: "Favourites")
        case .custom(let title):
            return MenuCellViewModelImplementation(title: title)
        }
    }

    func selectCell(inRow row: Int) {
        delegate?.playlistsMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        delegate?.playlistsMenuViewModelDidClickGoBack(self)
    }

}
