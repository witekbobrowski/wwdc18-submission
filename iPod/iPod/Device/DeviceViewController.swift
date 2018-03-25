//
//  DeviceViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

public class DeviceViewController: UIViewController {

    private var screenViewController: ScreenViewController!

    public override func loadView() {
        super.loadView()
        setupView()
    }

}

extension DeviceViewController {

    private func setupView() {
        let screenViewController = ScreenViewController()
        screenViewController.viewModel = ScreenViewModelImplementation()
        view.bottomAnchor.constraint(equalTo: screenViewController.view.bottomAnchor)
        view.topAnchor.constraint(equalTo: screenViewController.view.topAnchor)
        view.leftAnchor.constraint(equalTo: screenViewController.view.leftAnchor)
        view.rightAnchor.constraint(equalTo: screenViewController.view.rightAnchor)
        view.addSubview(screenViewController.view)
        self.screenViewController = screenViewController
    }

}
