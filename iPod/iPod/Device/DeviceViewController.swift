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
        static let inset: CGFloat = 20
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
        view.backgroundColor = Color.device
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 2
        setupScreen()
        setupOperatingSystem()
        setupControlPanel()
    }

    private func setupScreen() {
        let screenView = UIView()
        screenView.clipsToBounds = true
        view.addSubview(screenView)
        screenView.layer.borderColor = UIColor.darkGray.cgColor
        screenView.layer.borderWidth = 0.5
        screenView.layer.cornerRadius = Constants.screenCornerRadius
        screenView.translatesAutoresizingMaskIntoConstraints = false
        screenView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.inset).isActive = true
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
        addChildViewController(controlPanelVC)
        controlPanelVC.didMove(toParentViewController: self)
        view.addSubview(controlPanelVC.view)
        controlPanelVC.view.translatesAutoresizingMaskIntoConstraints = false
        controlPanelVC.view.topAnchor.constraint(equalTo: screenView.bottomAnchor,
                                                 constant: Constants.inset).isActive = true
        controlPanelVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        controlPanelVC.view.widthAnchor.constraint(equalToConstant: Constants.controlPanelSize).isActive = true
        controlPanelVC.view.heightAnchor.constraint(equalToConstant: Constants.controlPanelSize).isActive = true
        controlPanelVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: -Constants.inset).isActive = true
        controlPanelVC.view.leftAnchor.constraint(equalTo: view.leftAnchor,
                                                  constant: Constants.inset).isActive = true
        controlPanelVC.view.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                   constant: -Constants.inset).isActive = true
        self.controlPanelViewController = controlPanelVC
    }

}
