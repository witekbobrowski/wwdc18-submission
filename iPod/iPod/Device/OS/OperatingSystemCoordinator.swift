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

    init(window: UIView, coordinatorModel: OperatingSystemCoordinatorModel) {
        self.window = window
        self.coordinatorModel = coordinatorModel
    }

    func start() {
        let operatingSystemVC = coordinatorModel.operatingSystemViewController
        let mainMenuViewController = coordinatorModel.mainMenuViewController
        mainMenuViewController.viewModel.delegate = self
        operatingSystemVC.menuNavigationController.pushViewController(mainMenuViewController, animated: true)
        rootViewController = operatingSystemVC
        window.addSubview(operatingSystemVC.view)
        operatingSystemVC.view.translatesAutoresizingMaskIntoConstraints = false
        window.topAnchor.constraint(equalTo: operatingSystemVC.view.topAnchor).isActive = true
        window.bottomAnchor.constraint(equalTo: operatingSystemVC.view.bottomAnchor).isActive = true
        window.leftAnchor.constraint(equalTo: operatingSystemVC.view.leftAnchor).isActive = true
        window.rightAnchor.constraint(equalTo: operatingSystemVC.view.rightAnchor).isActive = true
    }

}

extension OperatingSystemCoordinator: MenuViewModelDelegate {

    func menuViewModel(_ menuViewModel: MenuViewModel, didSelectItem item: String) {
        let playlistViewController = coordinatorModel.playlistViewController
        playlistViewController.viewModel.delegate = self
        rootViewController?.menuNavigationController.pushViewController(playlistViewController, animated: true)
    }

    func menuViewModelDidClickGoBack(_ menuViewModel: MenuViewModel) {
        rootViewController?.menuNavigationController.popViewController(animated: true)
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
