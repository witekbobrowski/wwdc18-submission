//
//  StatusBarView.swift
//  iPod
//
//  Created by Witek Bobrowski on 25/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

enum PlayerStatus {
    case stopped
    case playing
    case paused
}

class StatusBarView: UIView {

    private enum Constants {
        static let inset: CGFloat = 4
    }

    private weak var titleLabel: UILabel!
    private weak var playerStatusView: UIView!
    private weak var batteryStatusView: UIView!
    private weak var bottomSeparatorView: UIView!
    private weak var playerStatusShapeLayer: CAShapeLayer?
    private weak var batteryStatusShapeLayer: CAShapeLayer?

    var title: String? { didSet { titleLabel.text = title } }
    var playerStatus: PlayerStatus = .stopped { didSet { setupPlayerLayer() } }
    var batteryPercentage: Float = 1 { didSet { setupBatteryLayer() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupPlayerLayer()
        setupBatteryLayer()
    }

}

extension StatusBarView {

    private func setupView() {
        setupPlayerStatusView()
        setupLabel()
        setupBatteryStatusView()
        setupSeparator()
    }

    private func setupPlayerStatusView() {
        let view = UIView()
        view.backgroundColor = Color.dark
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.inset).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: -Constants.inset).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: -Constants.inset).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        playerStatusView = view
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillRule = kCAFillRuleEvenOdd
        view.layer.mask = layer
        playerStatusShapeLayer = layer
    }

    private func setupLabel() {
        let titleLabel = UILabel()
        titleLabel.font = Font.normal
        titleLabel.textAlignment = .center
        titleLabel.textColor = Color.dark
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        self.titleLabel = titleLabel
    }

    private func setupBatteryStatusView() {
        let view = UIView()
        view.backgroundColor = Color.dark
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.inset).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.inset).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: -Constants.inset).isActive = true
        view.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        batteryStatusView = view
        let layer = CAShapeLayer()
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillRule = kCAFillRuleEvenOdd
        view.layer.mask = layer
        batteryStatusShapeLayer = layer
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

    private func setupPlayerLayer() {
        let rect = playerStatusView.bounds
        playerStatusShapeLayer?.frame = rect
        var path = UIBezierPath()
        switch playerStatus {
        case .paused:
            playerStatusView.isHidden = false
            path = UIBezierPath(rect: rect)
            let width = rect.width / 5
            path.append(UIBezierPath(rect: CGRect(x: rect.origin.x, y: rect.origin.y,
                                                  width: width/2, height: rect.height)))
            path.append(UIBezierPath(rect: CGRect(x: rect.midX - (width/2), y: rect.origin.y,
                                                  width: width, height: rect.height)))
            path.append(UIBezierPath(rect: CGRect(x: rect.maxX - (width/2), y: rect.origin.y,
                                                  width: width/2, height: rect.height)))
            path.usesEvenOddFillRule = true
        case .playing:
            playerStatusView.isHidden = false
            path.move(to: rect.origin)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: rect.origin)

        case .stopped:
            playerStatusView.isHidden = true
        }
        playerStatusShapeLayer?.path = path.cgPath
    }

    private func setupBatteryLayer() {
        let rect = batteryStatusView.bounds
        batteryStatusShapeLayer?.frame = rect
        let path = UIBezierPath()
        path.move(to: rect.origin)
        path.addLine(to: CGPoint(x: rect.maxX - 2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - 2, y: rect.midY - 3))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY - 3))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY + 3))
        path.addLine(to: CGPoint(x: rect.maxX - 2, y: rect.midY + 3))
        path.addLine(to: CGPoint(x: rect.maxX - 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: rect.origin)
        path.append(UIBezierPath(rect: CGRect(x: rect.maxX - 3, y: rect.midY - 2,
                                              width: 2, height: 4)))
        path.append(UIBezierPath(rect: CGRect(x: 1, y: 1,
                                              width: rect.width - 4, height: rect.height - 2)))
        batteryStatusShapeLayer?.path = path.cgPath
    }

}
