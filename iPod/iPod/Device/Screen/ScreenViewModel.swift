//
//  ScreenViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
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

protocol ScreenViewModel {
    var mainMenuViewModel: MenuViewModel { get }
}

class ScreenViewModelImplementation: ScreenViewModel {

    var mainMenuViewModel: MenuViewModel {
        let mainMenuItems: [MainMenuItem] = [.playlists, .browse, .extras, .settings, .about]
        let viewModel = MenuViewModelImplementation(options: mainMenuItems.map { $0.rawValue })
        return viewModel
    }
}

extension ScreenViewModelImplementation: MenuViewModelDelegate {

}
