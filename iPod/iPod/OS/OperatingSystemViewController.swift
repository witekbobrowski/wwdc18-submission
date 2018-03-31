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

    private(set) weak var statusBarView: StatusBarView!
    private(set) var menuNavigationController: UINavigationController!
    var viewModel: OperatingSystemViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }

}

extension OperatingSystemViewController {

    private func setupView() {
        view.clipsToBounds = true
        view.backgroundColor = Color.light
        setupStatusBar()
    }

    private func setupStatusBar() {
        let statusBarView = StatusBarView()
        statusBarView.title = viewModel.statusBarTitle
        statusBarView.playerStatus = .stopped
        statusBarView.batteryPercentage = viewModel.batteryPercentage
        view.addSubview(statusBarView)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: statusBarView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: statusBarView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: statusBarView.rightAnchor).isActive = true
        statusBarView.heightAnchor.constraint(equalToConstant: Constants.statusBarHeight).isActive = true
        self.statusBarView = statusBarView
    }

    private func setupNavigationController() {
        menuNavigationController = UINavigationController()
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
