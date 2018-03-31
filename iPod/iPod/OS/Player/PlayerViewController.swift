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
        static let labelHeight: CGFloat = 14
        static let progressBarHeight: CGFloat = 6
    }

    private weak var positionLabel: UILabel!
    private weak var songLabel: UILabel!
    private weak var authorLabel: UILabel!
    private weak var albumLabel: UILabel!
    private weak var volumeProgressView: ProgressView!

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
        setupVolumeProgressView()
        setupWithViewModel()
    }

    private func setupPositionLabel() {
        let label = UILabel()
        label.textColor = Color.dark
        label.font = Font.compact
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
        positionLabel = label
    }

    private func setupSongLabel() {
        let label = UILabel()
        label.textColor = Color.dark
        label.font = Font.normal
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
        songLabel = label
    }

    private func setupAuthorLabel() {
        let label = UILabel()
        label.textColor = Color.dark
        label.font = Font.normal
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
        authorLabel = label
    }

    private func setupAlbumLabel() {
        let label = UILabel()
        label.textColor = Color.dark
        label.font = Font.normal
        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
        albumLabel = label
    }

    private func setupVolumeProgressView() {
        let progressView = ProgressView()
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: Constants.labelInset).isActive = true
        progressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInset).isActive = true
        progressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInset).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: Constants.progressBarHeight).isActive = true
        self.volumeProgressView = progressView
    }

    private func setupWithViewModel() {
        positionLabel.text = viewModel.position
        songLabel.text = viewModel.song
        authorLabel.text = viewModel.author
        albumLabel.text = viewModel.album
        volumeProgressView.progress = viewModel.volume
    }

}

extension PlayerViewController: InputResponder {

    func respond(toInputType type: InputType) {
        switch type {
        case .menu:
            viewModel.goBackAction()
        case .enter, .play:
            viewModel.enterAction()
        case .next:
            viewModel.nextAction()
        case .previous:
            viewModel.previousAction()
        case .scroll(let status):
            switch status {
            case .next:
                viewModel.volumeUpAction()
            case .previous:
                viewModel.volumeDownAction()
            }
        }
        setupWithViewModel()
    }

}
