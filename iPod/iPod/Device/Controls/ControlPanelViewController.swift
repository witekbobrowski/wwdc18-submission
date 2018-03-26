//
//  ControlPanelViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ControlPanelViewController: UIViewController {

    private enum Constants {
        static let archButtonThickness: CGFloat = 18
        static let enterButtonRadius: CGFloat = 28
    }

    private weak var enterButton: UIButton!
    private weak var menuButton: ArchButton!
    private weak var playPauseButton: ArchButton!
    private weak var fastForwardButton: ArchButton!
    private weak var rewindButton: ArchButton!
    private weak var scrollWheel: ScrollWheel!

    var viewModel: ControlPanelViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

    @objc private func enterButtonDidTap(_ sender: UIButton) {
        viewModel.rewindButtonDidTap()
    }

    @objc private func menuButtonDidTap(_ sender: ArchButton) {
        viewModel.menuButtonDidTap()
    }

    @objc private func playPauseButtonDidTap(_ sender: ArchButton) {
        viewModel.playPauseButtonDidTap()
    }

    @objc private func fastForwardButtonDidTap(_ sender: ArchButton) {
        viewModel.fastForwardButtonDidTap()
    }

    @objc private func rewindButtonDidTap(_ sender: ArchButton) {
        viewModel.rewindButtonDidTap()
    }

    @objc private func scrollWheelDidChangeValue(_ sender: ScrollWheel) {
        guard let stateChange = sender.recentStateChange else { return }
        viewModel.scrollWheelDidChangeValue(withAction: stateChange)
    }

}

extension ControlPanelViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.clipsToBounds = true
        setupArchButtons()
        setupScrollWheel()
        setupEnterButton()
    }

    private func setupArchButtons() {
        let menuButton = ArchButton()
        menuButton.orientation = .regular
        let playPauseButton = ArchButton()
        playPauseButton.orientation = .upsiteDown
        let fastForwardButton = ArchButton()
        fastForwardButton.orientation = .rightTilt
        let rewindButton = ArchButton()
        rewindButton.orientation = .leftTilt
        [menuButton, playPauseButton, fastForwardButton, rewindButton].forEach { button in
            button.backgroundColor = Color.button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.thickness = Constants.archButtonThickness
            view.addSubview(button)
        }
        menuButton.addTarget(self, action: #selector(menuButtonDidTap(_:)), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonDidTap(_:)), for: .touchUpInside)
        fastForwardButton.addTarget(self, action: #selector(fastForwardButtonDidTap(_:)), for: .touchUpInside)
        rewindButton.addTarget(self, action: #selector(rewindButtonDidTap(_:)), for: .touchUpInside)
        self.menuButton = menuButton
        self.playPauseButton = playPauseButton
        self.fastForwardButton = fastForwardButton
        self.rewindButton = rewindButton
        constraintButtons()
    }

    private func setupScrollWheel() {
        let scrollWheel = ScrollWheel()
        scrollWheel.backgroundColor = Color.scrollWheel
        scrollWheel.holeRadius = Constants.enterButtonRadius
        scrollWheel.addTarget(self, action: #selector(scrollWheelDidChangeValue(_:)), for: .valueChanged)
        view.addSubview(scrollWheel)
        scrollWheel.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: scrollWheel.leftAnchor,
                                   constant: -Constants.archButtonThickness).isActive = true
        view.rightAnchor.constraint(equalTo: scrollWheel.rightAnchor,
                                    constant: Constants.archButtonThickness).isActive = true
        view.topAnchor.constraint(equalTo: scrollWheel.topAnchor,
                                  constant: -Constants.archButtonThickness).isActive = true
        view.bottomAnchor.constraint(equalTo: scrollWheel.bottomAnchor,
                                     constant: Constants.archButtonThickness).isActive = true
        self.scrollWheel = scrollWheel
    }

    private func setupEnterButton() {
        let enterButton = UIButton()
        enterButton.addTarget(self, action: #selector(enterButtonDidTap(_:)), for: .touchUpInside)
        view.addSubview(enterButton)
        enterButton.backgroundColor = Color.enterButton
        enterButton.layer.cornerRadius = Constants.enterButtonRadius
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: enterButton.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: enterButton.centerYAnchor).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonRadius * 2).isActive = true
        enterButton.widthAnchor.constraint(equalToConstant: Constants.enterButtonRadius * 2).isActive = true
        self.enterButton = enterButton
    }

    private func constraintButtons() {
        [menuButton, playPauseButton, rewindButton].flatMap { $0 }.forEach { button in
            view.leftAnchor.constraint(equalTo: button.leftAnchor).isActive = true
        }
        [menuButton, playPauseButton, fastForwardButton].flatMap { $0 }.forEach { button in
            view.rightAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        }
        [menuButton, rewindButton, fastForwardButton].flatMap { $0 }.forEach { button in
            view.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        }
        [playPauseButton, rewindButton, fastForwardButton].flatMap { $0 }.forEach { button in
            view.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        }
        menuButton.bottomAnchor.constraint(equalTo: playPauseButton.topAnchor).isActive = true
        rewindButton.rightAnchor.constraint(equalTo: fastForwardButton.leftAnchor).isActive = true
        menuButton.heightAnchor.constraint(equalTo: playPauseButton.heightAnchor).isActive = true
        rewindButton.widthAnchor.constraint(equalTo: fastForwardButton.widthAnchor).isActive = true
    }

}
