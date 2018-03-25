//
//  StatusBarView.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class StatusBarView: UIView {

    private weak var stackView: UIStackView!
    private weak var titleLabel: UILabel!
    private weak var playerImageView: UIImageView!
    private weak var batteryImageView: UIImageView!
    private weak var bottomSeparatorView: UIView!

    var viewModel: StatusBarViewModel? {
        didSet {
            update(with: viewModel)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

}

extension StatusBarView {

    private func setupView() {
        setupStackView()
        setupLabel()
        setupImageViews()
        setupSeparator()
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        [playerImageView, titleLabel, batteryImageView].forEach { stackView.addArrangedSubview($0) }
    }

    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        self.stackView = stackView
    }

    private func setupLabel() {
        let titleLabel = UILabel()
        titleLabel.font = Font.normalFont
        titleLabel.textAlignment = .center
        titleLabel.textColor = Color.dark
        self.titleLabel = titleLabel
    }

    private func setupImageViews() {
        let playerImageView = UIImageView()
        let batteryImageView = UIImageView()
        [playerImageView, batteryImageView].forEach { imageView in
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = Color.dark
        }
        self.playerImageView = playerImageView
        self.batteryImageView = batteryImageView
    }

    private func setupSeparator() {
        let separatorView = UIView()
        separatorView.backgroundColor = Color.dark
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: separatorView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: separatorView.rightAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1)
        bottomSeparatorView = separatorView
    }

    private func update(with viewModel: StatusBarViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        playerImageView.isHidden = !viewModel.isPlaying
    }

}
