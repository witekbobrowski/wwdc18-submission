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
    var artistsMenuViewController: MenuViewController { get }
    var songsMenuViewController: MenuViewController { get }
    var favouriteSongsMenuViewController: MenuViewController { get }
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
    var artistsMenuViewController: MenuViewController {
        return configuredArtistsMenuViewController()
    }
    var songsMenuViewController: MenuViewController {
        return configuredSongsMenuViewController(false)
    }
    var favouriteSongsMenuViewController: MenuViewController {
        return configuredSongsMenuViewController(true)
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
        let viewController = OperatingSystemViewController()
        let stausBarViewModel = statusBarViewModel(title: nil, isPlaying: false, isCharging: false)
        let osViewModel = OperatingSystemViewModelImplementation(statusBarViewModel: stausBarViewModel)
        viewController.viewModel = osViewModel
        viewController.view.isUserInteractionEnabled = false
        return viewController
    }

    private func configuredMainMenuViewController() -> MenuViewController {
        let viewController = MenuViewController()
        let menuItems: [MainMenuItem] = [.playlists, .artists, .songs, .settings, .about]
        viewController.viewModel = MainMenuViewModel(items: menuItems)
        return viewController
    }

    private func configuredPlaylistsMenuViewController() -> MenuViewController {
        let viewController = MenuViewController()
        let menuItems: [PlaylistsMenuItem] = [.favourites] + libraryService.playlists.map { .custom($0) }
        viewController.viewModel = PlaylistsMenuViewModel(items: menuItems)
        return viewController
    }

    private func configuredArtistsMenuViewController() -> MenuViewController {
        let viewController = MenuViewController()
        viewController.viewModel = ArtistsMenuViewModel(artists: libraryService.artists)
        return viewController
    }

    private func configuredSongsMenuViewController(_ favouriteSongs: Bool) -> MenuViewController {
        let viewController = MenuViewController()
        let songs: [Song] = favouriteSongs ? libraryService.favourites : libraryService.songs
        viewController.viewModel = SongsMenuViewModel(songs: songs)
        return viewController
    }

}
