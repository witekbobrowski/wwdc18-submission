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
        static let rowHeight: CGFloat = 16
    }

    private weak var tableView: UITableView!
    private var currentIndex: Int?

    public var viewModel: MenuViewModel!

    override func loadView() {
        super.loadView()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        guard let row = currentIndex ?? viewModel.rowInitallyHighlighed else { return }
        highlightCellAtRow(row)
    }

}

extension MenuViewController {

    private func setupTableView() {
        let tableView = UITableView()
        view = tableView
        tableView.dataSource = self
        tableView.backgroundColor = Color.light
        tableView.reloadData()
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.rowHeight
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: String(describing: MenuTableViewCell.self))
        self.tableView = tableView
        guard let row = viewModel.rowInitallyHighlighed else { return }
        highlightCellAtRow(row)
    }

    private func handleScroll(_ state: ScrollWheelStateChange) {
        guard let current = currentIndex else { return }
        switch state {
        case .next:
            highlightCellAtRow(current + 1, oldRow: current)
        case .previous:
            highlightCellAtRow(current - 1, oldRow: current)
        }
    }

    private func highlightCellAtRow(_ row: Int, oldRow: Int = 0) {
        guard row < viewModel.numberOfRows(inSection: 0) else { return }
        guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) else {
            return
        }
        if let oldCell = tableView.cellForRow(at: IndexPath(row: oldRow, section: 0)) {
            oldCell.setSelected(false, animated: false)
        }
        tableView.scrollRectToVisible(cell.frame, animated: false)
        cell.setSelected(true, animated: false)
        currentIndex = row
    }

}

extension MenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
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
        case .enter:
            guard let row = currentIndex else { return }
            viewModel.selectCell(inRow: row)
        case .menu:
            viewModel.goBack()
        default:
            break
        }
    }

}
