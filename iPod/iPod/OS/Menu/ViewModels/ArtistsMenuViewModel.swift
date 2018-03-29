//
//  ArtistsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum ArtistsMenuItem {
    case all
    case artist(Artist)
}

protocol ArtistsMenuViewModelDelegate: class {
    func artistsMenuViewModel(_ artistsMenuViewModel: ArtistsMenuViewModel, didSelectItem item: ArtistsMenuItem)
    func artistsMenuViewModelDidClickGoBack(_ artistsMenuViewModel: ArtistsMenuViewModel)
}

class ArtistsMenuViewModel: MenuViewModel {

    let items: [ArtistsMenuItem]
    weak var delegate: ArtistsMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return items.isEmpty ? nil : 0 }

    init(items: [ArtistsMenuItem]) {
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
        case .all:
            return MenuCellViewModelImplementation(title: Strings.all)
        case .artist(let artist):
            return MenuCellViewModelImplementation(title: artist.name)
        }
    }

    func selectCell(inRow row: Int) {
        delegate?.artistsMenuViewModel(self, didSelectItem: items[row])
    }

    func goBack() {
        delegate?.artistsMenuViewModelDidClickGoBack(self)
    }

}
