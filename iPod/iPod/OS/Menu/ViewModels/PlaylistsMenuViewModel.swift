//
//  PlaylistsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum PlaylistsMenuItem {
    case favourites([Song])
    case custom(Playlist)
}

protocol PlaylistsMenuViewModelDelegate: class {
    func playlistsMenuViewModel(_ playlistsMenuViewModel: PlaylistsMenuViewModel, didSelectItem item: PlaylistsMenuItem)
    func playlistsMenuViewModelDidClickGoBack(_ playlistsMenuViewModel: PlaylistsMenuViewModel)
}

class PlaylistsMenuViewModel: MenuViewModel {

    private let items: [PlaylistsMenuItem]
    weak var delegate: PlaylistsMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [PlaylistsMenuItem]) {
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
        case .favourites:
            return MenuCellViewModelImplementation(title: Strings.favourites)
        case .custom(let playlist):
            return MenuCellViewModelImplementation(title: playlist.title)
        }
    }

    func selectCell(inRow row: Int) {
        delegate?.playlistsMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        delegate?.playlistsMenuViewModelDidClickGoBack(self)
    }

}
