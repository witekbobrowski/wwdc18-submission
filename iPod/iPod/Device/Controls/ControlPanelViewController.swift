//
//  ControlPanelViewController.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ControlPanelViewController: UIViewController {

    private weak var menuButton: UIButton!
    private weak var playPauseButton: UIButton!
    private weak var fastForwardButton: UIButton!
    private weak var rewindButton: UIButton!

    var viewModel: ControlPanelViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

    @objc private func menuButtonDidTap(_ sender: UIButton) {
        viewModel.menuButtonDidTap()
    }

    @objc private func playPauseButtonDidTap(_ sender: UIButton) {
        viewModel.playPauseButtonDidTap()
    }

    @objc private func fastForwardButtonDidTap(_ sender: UIButton) {
        viewModel.fastForwardButtonDidTap()
    }

    @objc private func rewindButtonDidTap(_ sender: UIButton) {
        viewModel.rewindButtonDidTap()
    }

}

extension ControlPanelViewController {

    private func setupView() {
        view.backgroundColor = .clear
        view.clipsToBounds = true
        setupButtons()
    }

    private func setupButtons() {
        let menuButton = UIButton()
        let playPauseButton = UIButton()
        let fastForwardButton = UIButton()
        let rewindButton = UIButton()
        [menuButton, playPauseButton, fastForwardButton, rewindButton].forEach { button in
            button.backgroundColor = Color.buttonBackground
            button.translatesAutoresizingMaskIntoConstraints = false
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
