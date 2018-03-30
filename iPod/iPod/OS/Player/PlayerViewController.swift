//
//  PlayerViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    private enum Constants {
        static let edgeInset: CGFloat = 8
        static let labelInset: CGFloat = 4
        static let labelHeight: CGFloat = 18
    }

    private weak var positionLabel: UILabel!
    private weak var songLabel: UILabel!
    private weak var authorLabel: UILabel!
    private weak var albumLabel: UILabel!

    public var viewModel: PlayerViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

}

extension PlayerViewController {

    private func setupView() {
        view.backgroundColor = Color.light
        setupPositionLabel()
        setupSongLabel()
        setupAuthorLabel()
        setupAlbumLabel()
    }

    private func setupPositionLabel() {
        let label = UILabel()
        label.text = viewModel.position
        label.textColor = Color.dark
        label.font = Font.compact
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        positionLabel = label
    }

    private func setupSongLabel() {
        let label = UILabel()
        label.text = viewModel.song
        label.textColor = Color.dark
        label.font = Font.normal
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        songLabel = label
    }

    private func setupAuthorLabel() {
        let label = UILabel()
        label.text = viewModel.author
        label.textColor = Color.dark
        label.font = Font.normal
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        authorLabel = label
    }

    private func setupAlbumLabel() {
        let label = UILabel()
        label.text = viewModel.album
        label.textColor = Color.dark
        label.font = Font.normal
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        albumLabel = label
    }
}

extension PlayerViewController: InputResponder {

    func respond(toInputType type: InputType) {
        switch type {
        case .manu:
            viewModel.goBackAction()
        default:
            return
        }
    }

}
