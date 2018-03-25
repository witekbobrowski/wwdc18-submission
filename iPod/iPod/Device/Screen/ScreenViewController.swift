//
//  ScreenViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {

    private var menuNavigationController: UINavigationController!
    private var mainMenuViewController: UIViewController!

    var viewModel: ScreenViewModel!

    override func loadView() {
        super.loadView()
        setupMainMenu()
        setupNavigationController()
    }

}

extension ScreenViewController {

    private func setupMainMenu() {
        view.backgroundColor = Color.light
        let mainMenuViewModel = viewModel.mainMenuViewModel
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.viewModel = mainMenuViewModel
        self.mainMenuViewController = mainMenuViewController
    }

    private func setupNavigationController() {
        let navigationController = UINavigationController(rootViewController: mainMenuViewController)
        view.bottomAnchor.constraint(equalTo: navigationController.view.bottomAnchor)
        view.topAnchor.constraint(equalTo: navigationController.view.topAnchor)
        view.leftAnchor.constraint(equalTo: navigationController.view.leftAnchor)
        view.rightAnchor.constraint(equalTo: navigationController.view.rightAnchor)
        view.addSubview(navigationController.view)
        navigationController.setNavigationBarHidden(true, animated: false)
        menuNavigationController = navigationController
    }

}
