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
        static let controlPanelSize: CGFloat = 180
        static let screenCornerRadius: CGFloat = 4
    }

    private var operatingSystemViewController: OperatingSystemViewController!
    private var controlPanelViewController: ControlPanelViewController!

    var viewModel: DeviceViewModel!

    public override func loadView() {
        super.loadView()
        setupView()
    }

}

extension DeviceViewController {

    private func setupView() {
        setupOperatingSystem()
        setupControlPanel()
    }

    private func setupOperatingSystem() {
        let operatingSystemViewController = OperatingSystemViewController()
        operatingSystemViewController.viewModel = viewModel.operatingSystemViewModel
        view.addSubview(operatingSystemViewController.view)
        operatingSystemViewController.view.layer.cornerRadius = Constants.screenCornerRadius
        operatingSystemViewController.view.frame = CGRect(x: view.bounds.midX - Constants.screenWidth/2,
                                                          y: view.bounds.midY - Constants.screenHeight/2,
                                                          width: Constants.screenWidth,
                                                          height: Constants.screenHeight)
        self.operatingSystemViewController = operatingSystemViewController
    }

    private func setupControlPanel() {
        let controlPanelViewController = ControlPanelViewController()
        controlPanelViewController.viewModel = viewModel.controlPanelViewModel
        view.addSubview(controlPanelViewController.view)
        controlPanelViewController.view.layer.cornerRadius = Constants.controlPanelSize/2
        controlPanelViewController.view.frame = CGRect(x: view.bounds.midX - Constants.controlPanelSize/2,
                                                          y: view.bounds.midY + Constants.screenHeight/2 + 20,
                                                          width: Constants.controlPanelSize,
                                                          height: Constants.controlPanelSize)
        self.controlPanelViewController = controlPanelViewController
    }

}
