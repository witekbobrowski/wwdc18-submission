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
}

class OperatingSystemCoordinatorModelImplementation: OperatingSystemCoordinatorModel {

    var operatingSystemViewController: OperatingSystemViewController {
        return configuredOperatingSystemViewController()
    }

    var mainMenuViewController: MenuViewController {
        return configuredMainMenuViewController()
    }

    var playlistsMenuViewController: MenuViewController {
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
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.viewModel = MainMenuViewModel()
        return mainMenuViewController
    }

    private func configuredPlaylistsMenuViewController() -> MenuViewController {
        let playlistsMenuViewController = MenuViewController()
        let menuItems: [PlaylistsMenuItem] = [.favourites]
        playlistsMenuViewController.viewModel = PlaylistsMenuViewModel(items: menuItems)
        return playlistsMenuViewController
    }

}
