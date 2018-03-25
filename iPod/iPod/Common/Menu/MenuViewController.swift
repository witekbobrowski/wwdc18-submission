//
//  MenuViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private weak var tableView: UITableView!

    public var viewModel: MenuViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

}

extension MenuViewController {

    private func setupTableView() {
        let tableView = UITableView()
        
        tableView.dataSource = self
    }

}

extension MenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
    }

}
