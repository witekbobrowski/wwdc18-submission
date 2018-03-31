//
//  ProgressView.swift
//  iPod
//
//  Created by Witek Bobrowski on 31/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    private enum Constants {
        static let inset: CGFloat = 1
    }

    private weak var shapeLayer: CAShapeLayer?

    // Should always be in range [0;1]
    var progress: Float = 0.0 {
        didSet {
            setNeedsDisplay()
            recalculateLayer()
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

    override func layoutSubviews() {
        super.layoutSubviews()
        recalculateLayer()
    }

}

extension ProgressView {

    private func setupView() {
        backgroundColor = Color.dark
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        layer.mask = shapeLayer
        self.shapeLayer = shapeLayer
    }

    private func recalculateLayer() {
        shapeLayer?.frame = bounds
        let width = (bounds.width - Constants.inset * 2) * CGFloat(progress)
        let rect = CGRect(x: bounds.maxX - Constants.inset - width, y: bounds.minY + Constants.inset,
                          width: width, height: bounds.height - Constants.inset * 2)
        let path = UIBezierPath(rect: bounds)
        path.append(UIBezierPath(rect: rect))
        path.usesEvenOddFillRule = true
        shapeLayer?.path = path.cgPath
    }

}
