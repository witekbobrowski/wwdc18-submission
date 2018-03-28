//
//  StatusBarView.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class StatusBarView: UIView {

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
        setupLabel()
        setupImageViews()
        setupSeparator()
    }

    private func setupLabel() {
        let titleLabel = UILabel()
        titleLabel.font = Font.normal
        titleLabel.textAlignment = .center
        titleLabel.textColor = Color.dark
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        self.titleLabel = titleLabel
    }

    private func setupImageViews() {
        let playerImageView = UIImageView(image: UIImage())
        let batteryImageView = UIImageView(image: UIImage())
        [playerImageView, batteryImageView].forEach { imageView in
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = Color.dark
            addSubview(imageView)
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
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
