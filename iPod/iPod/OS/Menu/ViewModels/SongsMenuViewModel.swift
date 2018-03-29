//
//  SongsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum SongsMenuType {
    case favourites
    case all
    case artist(Artist)
    case album(Album)
}

enum SongsMenuItem {
    case all
    case song(Song)
}

protocol SongsMenuViewModelDelegate: class {
    func songsMenuViewModel(_ songsMenuViewModel: SongsMenuViewModel, didSelectItem item: SongsMenuItem)
    func songsMenuViewModelDidClickGoBack(_ songsMenuViewModel: SongsMenuViewModel)
}

class SongsMenuViewModel: MenuViewModel {

    let items: [SongsMenuItem]
    let type: SongsMenuType
    weak var delegate: SongsMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [SongsMenuItem], type: SongsMenuType) {
        self.items = items
        self.type = type
    }

    func numberOfSections() -> Int {
        return items.isEmpty ? 0 : 1
    }

    func numberOfRows(inSection section: Int) -> Int {
        return section == 0 ? items.count : 0
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        switch items[row] {
        case .all:
            return MenuCellViewModelImplementation(title: Strings.all)
        case .song(let song):
            return MenuCellViewModelImplementation(title: song.title)
        }
    }

    func selectCell(inRow row: Int) {
        delegate?.songsMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        delegate?.songsMenuViewModelDidClickGoBack(self)
    }

}
