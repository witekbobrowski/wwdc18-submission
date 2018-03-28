//
//  ArtistsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 28/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol ArtistsMenuViewModelDelegate: class {
    func artistsMenuViewModel(_ artistsMenuViewModel: ArtistsMenuViewModel, didSelectArtist artis: Artist)
    func artistsMenuViewModelDidClickGoBack(_ artistsMenuViewModel: ArtistsMenuViewModel)
}

class ArtistsMenuViewModel: MenuViewModel {

    let artists: [Artist]
    weak var delegate: ArtistsMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return artists.isEmpty ? nil : 0 }

    init(artists: [Artist]) {
        self.artists = artists
    }

    func numberOfSections() -> Int {
        return artists.isEmpty ? 0 : 1
    }

    func numberOfRows(inSection section: Int) -> Int {
        return section == 0 ? artists.count : 0
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        return MenuCellViewModelImplementation(title: artists[row].name)
    }

    func selectCell(inRow row: Int) {
        delegate?.artistsMenuViewModel(self, didSelectArtist: artists[row])
    }

    func goBack() {
        delegate?.artistsMenuViewModelDidClickGoBack(self)
    }

}
