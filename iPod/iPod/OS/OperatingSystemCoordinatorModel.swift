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
    func songsMenuViewController(_ type: SongsMenuType) -> MenuViewController
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

    init(libraryService: LibraryService) {
        self.libraryService = libraryService
    }

    func songsMenuViewController(_ type: SongsMenuType) -> MenuViewController {
        return configuredSongsMenuViewController(type)
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
        let menuItems: [ArtistsMenuItem] = [.all] + libraryService.artists.map { .artist($0) }
        viewController.viewModel = ArtistsMenuViewModel(items: menuItems)
        return viewController
    }

    private func configuredSongsMenuViewController(_ type: SongsMenuType) -> MenuViewController {
        let viewController = MenuViewController()
        var menuItems: [SongsMenuItem]
        switch type {
        case .all:
            menuItems = libraryService.songs.map { .song($0) }
        case .artist(let artist):
            menuItems = libraryService.albumsOfArtist(artist).reduce([]) {$0 + $1.songs}.map { .song($0) }
        case .album(let album):
            menuItems = album.songs.map { .song($0) }
        case .favourites:
            menuItems = libraryService.favourites.map { .song($0) }
        }
        viewController.viewModel = SongsMenuViewModel(items: menuItems, type: type)
        return viewController
    }

}
