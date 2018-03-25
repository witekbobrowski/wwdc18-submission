//
//  MenuTableViewCell.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    private enum Constants {
        static let inset: CGFloat = 4
    }

    private weak var stackView: UIStackView!
    private weak var titleLabel: UILabel!
    private weak var disclosureLabel: UILabel!

    var viewModel: MenuCellViewModel? {
        didSet {
            update(with: viewModel)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupLabels()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStackView()
        setupLabels()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? Color.dark : Color.light
        titleLabel.textColor = selected ? Color.light : Color.dark
        disclosureLabel.textColor = selected ? Color.light : Color.dark
    }

}

extension MenuTableViewCell {

    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: -Constants.inset).isActive = true
        rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: Constants.inset).isActive = true
        self.stackView = stackView
    }

    private func setupLabels() {
        let titleLabel = UILabel()
        let disclosureLabel = UILabel()
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        [titleLabel, disclosureLabel].forEach { label in
            label.font = Font.normal
            stackView.addArrangedSubview(label)
        }
        disclosureLabel.textAlignment = .right
        self.titleLabel = titleLabel
        self.disclosureLabel = disclosureLabel
    }

    private func update(with viewModel: MenuCellViewModel?) {
        guard let viewModel = viewModel else {
            clearCell()
            return
        }
        titleLabel.text = viewModel.title
        disclosureLabel.text = viewModel.disclosure
    }

    private func clearCell() {
        [titleLabel, disclosureLabel].forEach { $0?.text = "" }
    }

}
