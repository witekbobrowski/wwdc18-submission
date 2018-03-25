//
//  DeviceViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

public class DeviceViewController: UIViewController {

    private var screenViewController: UIViewController!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension DeviceViewController {

    private func setupView() {
        self.view = screenViewController.view
    }

}
