//
//  OperatingSystemCoordinator.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class OperatingSystemCoordinator: Coordinator {

    private let window: UIView
    private let coordinatorModel: OperatingSystemCoordinatorModel

    var rootViewController: OperatingSystemViewController?
    var animatedTransitions: Bool = true

    init(window: UIView, coordinatorModel: OperatingSystemCoordinatorModel) {
        self.window = window
        self.coordinatorModel = coordinatorModel
    }

    func start() {
        let operatingSystemVC = coordinatorModel.operatingSystemViewController
        let viewController = coordinatorModel.mainMenuViewController
        if let viewModel = viewController.viewModel as? MainMenuViewModel {
            viewModel.delegate = self
        }
        operatingSystemVC.menuNavigationController.pushViewController(viewController, animated: animatedTransitions)
        rootViewController = operatingSystemVC
        window.addSubview(operatingSystemVC.view)
        operatingSystemVC.view.translatesAutoresizingMaskIntoConstraints = false
        window.topAnchor.constraint(equalTo: operatingSystemVC.view.topAnchor).isActive = true
        window.bottomAnchor.constraint(equalTo: operatingSystemVC.view.bottomAnchor).isActive = true
        window.leftAnchor.constraint(equalTo: operatingSystemVC.view.leftAnchor).isActive = true
        window.rightAnchor.constraint(equalTo: operatingSystemVC.view.rightAnchor).isActive = true
    }

    private func updateStatusBar(withTitle title: String?, isPlaying: Bool, isCharging: Bool) {
        rootViewController?.statusBarView.viewModel = coordinatorModel.statusBarViewModel(title: title, isPlaying: isPlaying, isCharging: isCharging)
    }

}

extension OperatingSystemCoordinator: MainMenuViewModelDelegate {

    func mainMenuViewModel(_ mainMenuViewModel: MainMenuViewModel, didSelectItem item: MainMenuItem) {
        var viewController: MenuViewController
        switch item {
        case .playlists:
            viewController = coordinatorModel.playlistsMenuViewController
            if let viewModel = viewController.viewModel as? PlaylistsMenuViewModel {
                viewModel.delegate = self
            }
        case .artists:
            viewController = coordinatorModel.artistsMenuViewController
            if let viewModel = viewController.viewModel as? ArtistsMenuViewModel {
                viewModel.delegate = self
            }
        case .settings: return
        case .songs: return
        case .about: return
        case .nowPlaying: return
        }
        rootViewController?.menuNavigationController.pushViewController(viewController, animated: animatedTransitions)
        updateStatusBar(withTitle: item.rawValue, isPlaying: false, isCharging: false)
    }

}

extension OperatingSystemCoordinator: PlaylistsMenuViewModelDelegate {

    func playlistsMenuViewModel(_ playlistsMenuViewModel: PlaylistsMenuViewModel, didSelectItem item: PlaylistsMenuItem) {
        return // TODO
    }

    func playlistsMenuViewModelDidClickGoBack(_ playlistsMenuViewModel: PlaylistsMenuViewModel) {
        rootViewController?.menuNavigationController.popViewController(animated: animatedTransitions)
        updateStatusBar(withTitle: nil, isPlaying: false, isCharging: false)
    }

}

extension OperatingSystemCoordinator: ArtistsMenuViewModelDelegate {

    func artistsMenuViewModel(_ artistsMenuViewModel: ArtistsMenuViewModel, didSelectArtist artis: Artist) {
        return // TODO
    }

    func artistsMenuViewModelDidClickGoBack(_ artistsMenuViewModel: ArtistsMenuViewModel) {
        rootViewController?.menuNavigationController.popViewController(animated: animatedTransitions)
        updateStatusBar(withTitle: nil, isPlaying: false, isCharging: false)
    }


}

extension OperatingSystemCoordinator: InputResponder {

    func respond(toInputType type: InputType) {
        guard
            let topViewController = rootViewController?.menuNavigationController.topViewController,
            let responder = topViewController as? InputResponder
        else { return }
        responder.respond(toInputType: type)
    }

}
