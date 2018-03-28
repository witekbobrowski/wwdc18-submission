//
//  AlbumsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum AlbumsMenuType {
    case all
    case artist(Artist)
}

enum AlbumsMenuItem {
    case all
    case album(Album)
}

protocol AlbumsMenuViewModelDelegate: class {
    func albumsMenuViewModel(_ albumsMenuViewModel: AlbumsMenuViewModel, didSelectItem item: AlbumsMenuItem)
    func albumsMenuViewModelDidClickGoBack(_ albumsMenuViewModel: AlbumsMenuViewModel)
}

class AlbumsMenuViewModel: MenuViewModel {

    let items: [AlbumsMenuItem]
    let type: AlbumsMenuType
    weak var delegate: AlbumsMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [AlbumsMenuItem], type: AlbumsMenuType) {
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
            return MenuCellViewModelImplementation(title: "All")
        case .album(let album):
            return MenuCellViewModelImplementation(title: album.title)
        }
    }

    func selectCell(inRow row: Int) {
        delegate?.albumsMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        delegate?.albumsMenuViewModelDidClickGoBack(self)
    }

}
