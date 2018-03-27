//
//  OperatingSystemViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class OperatingSystemViewController: UIViewController {

    private enum Constants {
        static let statusBarHeight: CGFloat = 18
        static let stausBarInset: CGFloat = 1
    }

    private weak var statusBarView: StatusBarView!

    var menuNavigationController: UINavigationController!
    var viewModel: OperatingSystemViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

}

extension OperatingSystemViewController {

    private func setupView() {
        view.clipsToBounds = true
        view.backgroundColor = Color.light
        setupStatusBar()
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

    private func setupNavigationController() {
        view.addSubview(menuNavigationController.view)
        menuNavigationController.view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: menuNavigationController.view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: menuNavigationController.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: menuNavigationController.view.rightAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: menuNavigationController.view.topAnchor,
                                              constant: -Constants.stausBarInset).isActive = true
        menuNavigationController.setNavigationBarHidden(true, animated: false)
    }

}
