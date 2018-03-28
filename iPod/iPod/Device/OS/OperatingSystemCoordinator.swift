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
        case .browse: return
        case .settings: return
        case .extras: return
        case .about: return
        }
        rootViewController?.menuNavigationController.pushViewController(viewController, animated: animatedTransitions)
    }

}

extension OperatingSystemCoordinator: PlaylistsMenuViewModelDelegate {

    func playlistsMenuViewModel(_ playlistsMenuViewModel: PlaylistsMenuViewModel, didSelectItem item: PlaylistsMenuItem) {
        return
    }

    func playlistsMenuViewModelDidClickGoBack(_ playlistsMenuViewModel: PlaylistsMenuViewModel) {
        rootViewController?.menuNavigationController.popViewController(animated: animatedTransitions)
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
