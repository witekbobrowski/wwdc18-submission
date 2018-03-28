//
//  SongsMenuViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol SongsMenuViewModelDelegate: class {
    func songsMenuViewModel(_ songsMenuViewModel: SongsMenuViewModel, didSelectSong song: Song)
    func songsMenuViewModelDidClickGoBack(_ songsMenuViewModel: SongsMenuViewModel)
}

class SongsMenuViewModel: MenuViewModel {

    let songs: [Song]
    weak var delegate: SongsMenuViewModelDelegate?
    var rowInitallyHighlighed: Int? { return songs.isEmpty ? nil : 0 }

    init(songs: [Song]) {
        self.songs = songs
    }

    func numberOfSections() -> Int {
        return songs.isEmpty ? 0 : 1
    }

    func numberOfRows(inSection section: Int) -> Int {
        return section == 0 ? songs.count : 0
    }

    func viewModelForCell(inRow row: Int) -> MenuCellViewModel {
        return MenuCellViewModelImplementation(title: songs[row].title)
    }

    func selectCell(inRow row: Int) {
        delegate?.songsMenuViewModel(self, didSelectSong: songs[row])
    }

    func goBack() {
        delegate?.songsMenuViewModelDidClickGoBack(self)
    }

}
