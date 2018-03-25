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

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension ScreenViewController {

    private func setupView() {
        self.view = menuNavigationController.view
    }

}
