//
//  AboutViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 01/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    private enum Constants {
        static let inset: CGFloat = 4
        static let titleHeight: CGFloat = 20
        static let footnoteHeight: CGFloat = 16
    }

    public var viewModel: AboutViewModel!

    private weak var titleLabel: UILabel!
    private weak var descriptionLabel: UILabel!
    private weak var footnoteLabel: UILabel!

    override func loadView() {
        super.loadView()
        setupView()
    }

}

extension AboutViewController {

    private func setupView() {
        view.backgroundColor = Color.light
        setupTitleLabel()
        setupFootnoteLabel()
        setupDescriptionLabel()
    }

    private func setupTitleLabel() {
        let label = UILabel()
        label.text = viewModel.title
        label.font = Font.normal
        label.textColor = Color.dark
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: label.topAnchor,
                                  constant: -Constants.inset).isActive = true
        view.leftAnchor.constraint(equalTo: label.leftAnchor,
                                   constant: -Constants.inset).isActive = true
        view.rightAnchor.constraint(equalTo: label.rightAnchor,
                                    constant: Constants.inset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.titleHeight).isActive = true
        titleLabel = label
    }

    private func setupDescriptionLabel() {
        let label = UILabel()
        label.text = viewModel.description
        label.numberOfLines = 0
        label.font = Font.compact
        label.textColor = Color.dark
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        footnoteLabel.topAnchor.constraint(equalTo: label.bottomAnchor,
                                           constant: Constants.inset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: label.topAnchor,
                                           constant: -Constants.inset).isActive = true
        view.leftAnchor.constraint(equalTo: label.leftAnchor,
                                   constant: -Constants.inset).isActive = true
        view.rightAnchor.constraint(equalTo: label.rightAnchor,
                                    constant: Constants.inset).isActive = true
        descriptionLabel = label
    }

    private func setupFootnoteLabel() {
        let label = UILabel()
        label.text = viewModel.footnote
        label.font = Font.compact
        label.textColor = Color.dark
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: label.bottomAnchor,
                                     constant: Constants.inset).isActive = true
        view.leftAnchor.constraint(equalTo: label.leftAnchor,
                                   constant: -Constants.inset).isActive = true
        view.rightAnchor.constraint(equalTo: label.rightAnchor,
                                    constant: Constants.inset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.footnoteHeight).isActive = true
        footnoteLabel = label
    }

}

extension AboutViewController: InputResponder {

    func respond(toInputType type: InputType) {
        switch type {
        case .menu:
            viewModel.menuAction()
        default:
            return
        }
    }

}
