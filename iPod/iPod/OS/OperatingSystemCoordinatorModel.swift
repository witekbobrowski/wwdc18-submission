//
//  OperatingSystemCoordinatorModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol OperatingSystemCoordinatorModel {
    var operatingSystemViewController: OperatingSystemViewController { get }
    var mainMenuViewController: MenuViewController { get }
    var playlistsMenuViewController: MenuViewController { get }
    func statusBarViewModel(title: String?, isPlaying: Bool, isCharging: Bool) -> StatusBarViewModel
}

class OperatingSystemCoordinatorModelImplementation: OperatingSystemCoordinatorModel {

    let libraryService: LibraryService

    var operatingSystemViewController: OperatingSystemViewController {
        return configuredOperatingSystemViewController()
    }
    var mainMenuViewController: MenuViewController {
        return configuredMainMenuViewController()
    }
    var playlistsMenuViewController: MenuViewController {
        return configuredPlaylistsMenuViewController()
    }

    init(libraryService: LibraryService) {
        self.libraryService = libraryService
    }

    func statusBarViewModel(title: String?, isPlaying: Bool, isCharging: Bool) -> StatusBarViewModel {
        return StatusBarViewModelImplementation(title: title ?? "iPod", isPlaying: isPlaying, isCharging: isCharging)
    }

}

extension OperatingSystemCoordinatorModelImplementation {

    private func configuredOperatingSystemViewController() -> OperatingSystemViewController {
        let operatingSystemViewController = OperatingSystemViewController()
        let stausBarViewModel = statusBarViewModel(title: nil, isPlaying: false, isCharging: false)
        let osViewModel = OperatingSystemViewModelImplementation(statusBarViewModel: stausBarViewModel)
        operatingSystemViewController.viewModel = osViewModel
        operatingSystemViewController.view.isUserInteractionEnabled = false
        return operatingSystemViewController
    }

    private func configuredMainMenuViewController() -> MenuViewController {
        let mainMenuViewController = MenuViewController()
        let menuItems: [MainMenuItem] = [.playlists, .artists, .songs, .settings, .about]
        mainMenuViewController.viewModel = MainMenuViewModel(items: menuItems)
        return mainMenuViewController
    }

    private func configuredPlaylistsMenuViewController() -> MenuViewController {
        let playlistsMenuViewController = MenuViewController()
        let menuItems: [PlaylistsMenuItem] = [.favourites]
        playlistsMenuViewController.viewModel = PlaylistsMenuViewModel(items: menuItems)
        return playlistsMenuViewController
    }

}
