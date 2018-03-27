//
//  OperatingSystemCoordinator.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class OperatingSystemCoordinator: Coordinator {

    var rootViewController: UIViewController?

    private let window: UIView

    init(window: UIView) {
        self.window = window
    }

    func start() {
        let operatingSystemVC = operatingSystemViewController()
        rootViewController = operatingSystemViewController()
        window.topAnchor.constraint(equalTo: operatingSystemVC.view.topAnchor).isActive = true
        window.bottomAnchor.constraint(equalTo: operatingSystemVC.view.bottomAnchor).isActive = true
        window.leftAnchor.constraint(equalTo: operatingSystemVC.view.leftAnchor).isActive = true
        window.rightAnchor.constraint(equalTo: operatingSystemVC.view.rightAnchor).isActive = true
    }

}

extension OperatingSystemCoordinator {

    private func operatingSystemViewController() -> OperatingSystemViewController {
        let operatingSystemViewController = OperatingSystemViewController()
        operatingSystemViewController.viewModel = OperatingSystemViewModelImplementation()
        operatingSystemViewController.view.isUserInteractionEnabled = false
        return operatingSystemViewController
    }

}
