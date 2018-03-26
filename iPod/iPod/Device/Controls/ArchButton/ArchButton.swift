//
//  ArchButton.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

enum ArchOrientation {
    case regular
    case upsiteDown
    case leftTilt
    case rightTilt
}

class ArchButton: UIButton {

    private weak var shapeLayer: CAShapeLayer?

    var orientation: ArchOrientation = .regular { didSet { recalculateLayer() } }
    var thickness: CGFloat = 18

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
        recalculateLayer()
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return shapeLayer?.path?.contains(point) ?? true
    }

}

extension ArchButton {

    private func setupView() {
        backgroundColor = Color.buttonBackground
        clipsToBounds = true
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        layer.mask = shapeLayer
        self.shapeLayer = shapeLayer
    }

    private func recalculateLayer() {
        shapeLayer?.frame = bounds
        let path = UIBezierPath()
        switch orientation {
        case .regular:
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.maxY), radius: bounds.height,
                        startAngle: .pi * 1.25 , endAngle: .pi * 1.75, clockwise: true)
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.maxY), radius: bounds.height - thickness,
                        startAngle: .pi * 1.75, endAngle: .pi * 1.25, clockwise: false)
        case .upsiteDown:
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.minY), radius: bounds.height,
                        startAngle: .pi * 0.25, endAngle: .pi * 0.75, clockwise: true)
            path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.minY), radius: bounds.height - thickness,
                        startAngle: .pi * 0.75 , endAngle: .pi * 0.25, clockwise: false)

        case .leftTilt:
            path.addArc(withCenter: CGPoint(x: bounds.maxX, y: bounds.midY), radius: bounds.width,
                        startAngle: .pi * 0.75, endAngle: .pi * 1.25, clockwise: true)
            path.addArc(withCenter: CGPoint(x: bounds.maxX, y: bounds.midY), radius: bounds.width - thickness,
                        startAngle: .pi * 1.25, endAngle: .pi * 0.75, clockwise: false)

        case .rightTilt:
            path.addArc(withCenter: CGPoint(x: bounds.minX, y: bounds.midY), radius: bounds.width,
                        startAngle: .pi * 1.75, endAngle: .pi * 0.25, clockwise: true)
            path.addArc(withCenter: CGPoint(x: bounds.minX, y: bounds.midY), radius: bounds.width - thickness,
                        startAngle: .pi * 0.25, endAngle: .pi * 1.75, clockwise: false)

        }
        shapeLayer?.path = path.cgPath
    }

}
