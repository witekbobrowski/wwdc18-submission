//
//  OperatingSystemViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
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

protocol OperatingSystemViewModel: InputResponder {
    var statusBarViewModel: StatusBarViewModel { get }
    var mainMenuViewModel: MenuViewModel { get }
}

class OperatingSystemViewModelImplementation: OperatingSystemViewModel {

    let mainMenuItems: [MainMenuItem] = [.playlists, .browse, .extras, .settings, .about]
    let playlistMenuItems: [PlaylistMenuItem] = [.favourites]

    var statusBarViewModel: StatusBarViewModel {
        return StatusBarViewModelImplementation(title: "iPod", isPlaying: false, isCharging: false)
    }

    private(set) lazy var mainMenuViewModel: MenuViewModel = {
        let viewModel = MenuViewModelImplementation(items: mainMenuItems.map { $0.rawValue })
        viewModel.delegate = self
        return viewModel
    }()

    func respond(toInputType type: InputType) {
        mainMenuViewModel.responder?.respond(toInputType: type)
    }

}

extension OperatingSystemViewModelImplementation: MenuViewModelDelegate {

    func menuViewModel(_ menuViewModel: MenuViewModel, didSelectItem item: String) {
        print("User did select item: \(item)")
    }

}
