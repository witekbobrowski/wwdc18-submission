//
//  DeviceViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

public class DeviceViewController: UIViewController {

    private enum Constants {
        static let screenHeight: CGFloat = 128
        static let screenWidth: CGFloat = 160
        static let controlPanelSize: CGFloat = 200
        static let screenCornerRadius: CGFloat = 4
    }

    private weak var screenView: UIView!
    private var operatingSystemCoordinator: OperatingSystemCoordinator!
    private var controlPanelViewController: ControlPanelViewController!

    var viewModel: DeviceViewModel!

    public override func loadView() {
        super.loadView()
        setupView()
    }

}

extension DeviceViewController {

    private func setupView() {
        setupScreen()
        setupOperatingSystem()
        setupControlPanel()
    }

    private func setupScreen() {
        let screenView = UIView()
        view.addSubview(screenView)
        screenView.translatesAutoresizingMaskIntoConstraints = false
        screenView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        screenView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        screenView.widthAnchor.constraint(equalToConstant: Constants.screenWidth).isActive = true
        screenView.heightAnchor.constraint(equalToConstant: Constants.screenHeight).isActive = true
        self.screenView = screenView
    }

    private func setupOperatingSystem() {
        let operatingSystemCoordinator = OperatingSystemCoordinator(window: screenView, coordinatorModel: viewModel.operatingSystemCoordinatorModel)
        viewModel.inputResponder = operatingSystemCoordinator
        operatingSystemCoordinator.start()
        self.operatingSystemCoordinator = operatingSystemCoordinator
    }

    private func setupControlPanel() {
        let controlPanelVC = ControlPanelViewController()
        controlPanelVC.viewModel = viewModel.controlPanelViewModel
        view.addSubview(controlPanelVC.view)
        controlPanelVC.view.translatesAutoresizingMaskIntoConstraints = false
        controlPanelVC.view.topAnchor.constraint(equalTo: screenView.bottomAnchor, constant: 20).isActive = true
        controlPanelVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        controlPanelVC.view.widthAnchor.constraint(equalToConstant: Constants.controlPanelSize).isActive = true
        controlPanelVC.view.heightAnchor.constraint(equalToConstant: Constants.controlPanelSize).isActive = true
        self.controlPanelViewController = controlPanelVC
    }

}
