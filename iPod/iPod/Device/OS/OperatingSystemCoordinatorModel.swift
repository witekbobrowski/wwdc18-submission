//
//  OperatingSystemCoordinatorModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

enum MainMenuItem: String {
    case playlists = "Playlists"
    case browse = "Browse"
    case extras = "Extras"
    case settings = "Settings"
    case about = "About"
}

enum PlaylistMenuItem: String {
    case favourites = "Favourites"
}

protocol OperatingSystemCoordinatorModel {
    var operatingSystemViewController: OperatingSystemViewController { get }
    var mainMenuViewController: MenuViewController { get }
    var playlistViewController: MenuViewController { get }
}

class OperatingSystemCoordinatorModelImplementation: OperatingSystemCoordinatorModel {

    var operatingSystemViewController: OperatingSystemViewController {
        return configuredOperatingSystemViewController()
    }

    var mainMenuViewController: MenuViewController {
        return configuredMainMenuViewController()
    }

    var playlistViewController: MenuViewController {
        return configuredPlaylistsMenuViewController()
    }

}

extension OperatingSystemCoordinatorModelImplementation {

    private func configuredOperatingSystemViewController() -> OperatingSystemViewController {
        let operatingSystemViewController = OperatingSystemViewController()
        operatingSystemViewController.viewModel = OperatingSystemViewModelImplementation()
        operatingSystemViewController.view.isUserInteractionEnabled = false
        return operatingSystemViewController
    }

    private func configuredMainMenuViewController() -> MenuViewController {
        let mainMenuItems: [MainMenuItem] = [.playlists, .browse, .extras, .settings, .about]
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.viewModel = MenuViewModelImplementation(items: mainMenuItems.map { $0.rawValue })
        return mainMenuViewController
    }

    private func configuredPlaylistsMenuViewController() -> MenuViewController {
        let playlistsMenuItems: [PlaylistMenuItem] = [.favourites]
        let playlistsMenuViewController = MenuViewController()
        playlistsMenuViewController.viewModel = MenuViewModelImplementation(items: playlistsMenuItems.map { $0.rawValue })
        return playlistsMenuViewController
    }

}
