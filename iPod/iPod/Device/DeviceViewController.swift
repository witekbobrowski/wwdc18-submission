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
    }

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
        view.addSubview(screenViewController.view)
        screenViewController.view.frame = CGRect(x: view.bounds.midX - Constants.screenWidth/2,
                                                 y: view.bounds.midY - Constants.screenHeight/2,
                                                 width: Constants.screenWidth, height: Constants.screenHeight)
        self.screenViewController = screenViewController
    }

}
