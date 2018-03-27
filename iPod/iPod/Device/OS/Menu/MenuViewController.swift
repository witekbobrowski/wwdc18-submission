//
//  MenuViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private enum Constants {
        static let rowHeight: CGFloat = 18
    }

    private weak var tableView: UITableView!

    public var viewModel: MenuViewModel!

    override func loadView() {
        super.loadView()
        setupTableView()
    }

}

extension MenuViewController {

    private func setupTableView() {
        let tableView = UITableView()
        view = tableView
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.reloadData()
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.rowHeight
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: String(describing: MenuTableViewCell.self))
        self.tableView = tableView
        guard let row = viewModel.rowInitallyHighlighed else { return }
        tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .top)
    }

    private func handleScroll(_ state: ScrollWheelStateChange) {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuTableViewCell.self)) as! MenuTableViewCell
        cell.viewModel = viewModel.viewModelForCell(inRow: indexPath.row)
        return cell
    }

}

extension MenuViewController: InputResponder {

    func respond(toInputType type: InputType) {
        switch type {
        case .scroll(let state):
            handleScroll(state)
        default:
            break
        }
    }

}
