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
    private weak var nextButton: ArchButton!
    private weak var previousButton: ArchButton!
    private weak var scrollWheel: ScrollWheel!

    var viewModel: ControlPanelViewModel!

    override func loadView() {
        super.loadView()
        setupView()
    }

    @objc private func enterButtonDidTap(_ sender: UIButton) {
        viewModel.enterAction()
    }

    @objc private func archButtonDidTap(_ sender: ArchButton) {
        switch sender.orientation {
        case .regular:
            viewModel.menuAction()
        case .upsiteDown:
            viewModel.playAction()
        case .leftTilt:
            viewModel.previousAction()
        case .rightTilt:
            viewModel.nextAction()
        }
    }

    @objc private func scrollWheelDidChangeValue(_ sender: ScrollWheel) {
        guard let stateChange = sender.recentStateChange else { return }
        viewModel.scrollAction(withState: stateChange)
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
        let nextButton = ArchButton()
        nextButton.orientation = .rightTilt
        let previousButton = ArchButton()
        previousButton.orientation = .leftTilt
        [menuButton, playPauseButton, nextButton, previousButton].forEach { button in
            button.backgroundColor = Color.button
            button.translatesAutoresizingMaskIntoConstraints = false
            button.thickness = Constants.archButtonThickness
            button.addTarget(self, action: #selector(archButtonDidTap(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
        self.menuButton = menuButton
        self.playPauseButton = playPauseButton
        self.nextButton = nextButton
        self.previousButton = previousButton
        constraintButtons()
        setupButtonTitles()
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
        [menuButton, playPauseButton, previousButton].flatMap { $0 }.forEach { button in
            view.leftAnchor.constraint(equalTo: button.leftAnchor).isActive = true
        }
        [menuButton, playPauseButton, nextButton].flatMap { $0 }.forEach { button in
            view.rightAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        }
        [menuButton, previousButton, nextButton].flatMap { $0 }.forEach { button in
            view.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        }
        [playPauseButton, previousButton, nextButton].flatMap { $0 }.forEach { button in
            view.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        }
        menuButton.bottomAnchor.constraint(equalTo: playPauseButton.topAnchor).isActive = true
        previousButton.rightAnchor.constraint(equalTo: nextButton.leftAnchor).isActive = true
        menuButton.heightAnchor.constraint(equalTo: playPauseButton.heightAnchor).isActive = true
        previousButton.widthAnchor.constraint(equalTo: nextButton.widthAnchor).isActive = true
    }

    private func setupButtonTitles() {
        menuButton.setTitle(viewModel.menuButtonTitle, for: .normal)
        menuButton.contentVerticalAlignment = .top
        menuButton.titleEdgeInsets = UIEdgeInsetsMake(-2, 0, 0, 0)
        playPauseButton.setTitle(viewModel.playButtonTitle, for: .normal)
        playPauseButton.contentVerticalAlignment = .bottom
        playPauseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -2, 0)
        previousButton.setTitle(viewModel.previousButtonTitle, for: .normal)
        previousButton.contentHorizontalAlignment = .left
        previousButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0)
        nextButton.setTitle(viewModel.nextButtonTitle, for: .normal)
        nextButton.contentHorizontalAlignment = .right
        nextButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 2)
        [menuButton, playPauseButton, previousButton, nextButton].forEach { button in
            button?.titleLabel?.font = Font.compact
            button?.setTitleColor(Color.dark, for: .normal)
        }
    }

}
