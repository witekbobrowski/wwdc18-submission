//
//  ScreenViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {

    private enum Constants {
        static let statusBarHeight: CGFloat = 18
        static let stausBarInset: CGFloat = 1
    }

    private weak var statusBarView: StatusBarView!
    private var menuNavigationController: UINavigationController!
    private var mainMenuViewController: UIViewController!

    var viewModel: ScreenViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

}

extension ScreenViewController {

    private func setupView() {
        view.backgroundColor = Color.light
        setupStatusBar()
        setupMainMenu()
        setupNavigationController()
    }

    private func setupStatusBar() {
        let statusBarView = StatusBarView()
        statusBarView.viewModel = viewModel.statusBarViewModel
        view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: statusBarView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: statusBarView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: statusBarView.rightAnchor).isActive = true
        statusBarView.heightAnchor.constraint(equalToConstant: Constants.statusBarHeight).isActive = true
        self.statusBarView = statusBarView
    }

    private func setupMainMenu() {
        let mainMenuViewModel = viewModel.mainMenuViewModel
        let mainMenuViewController = MenuViewController()
        mainMenuViewController.viewModel = mainMenuViewModel
        self.mainMenuViewController = mainMenuViewController
    }

    private func setupNavigationController() {
        let navigationController = UINavigationController(rootViewController: mainMenuViewController)
        view.addSubview(navigationController.view)
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: navigationController.view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: navigationController.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: navigationController.view.rightAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: navigationController.view.topAnchor,
                                              constant: -Constants.stausBarInset).isActive = true
        navigationController.setNavigationBarHidden(true, animated: false)
        menuNavigationController = navigationController
    }

}
