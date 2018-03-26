//
//  ScrollWheel.swift
//  iPod
//
//  Created by Witek Bobrowski on 26/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

enum ScrollWheelStateChange {
    case next
    case previous
}

class ScrollWheel: UIControl {

    private weak var shapeLayer: CAShapeLayer?
    private var currentStep: Int?

    private(set) var isTouched: Bool = false

    var recentStateChange: ScrollWheelStateChange? {
        didSet {
            if isTouched { sendActions(for: .valueChanged) }
        }
    }
    var holeRadius: CGFloat = 28 { didSet { recalculateLayer() } }
    var numberOfSteps: Int = 16


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

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard !isTouched else { return false }
        currentStep = getCurrentStep(onTouch: touch)
        isTouched = true
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let steps = getCurrentStep(onTouch: touch)
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        isTouched = false
    }

}

extension ScrollWheel {

    private func setupView() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        layer.mask = shapeLayer
        self.shapeLayer = shapeLayer
    }

    private func recalculateLayer() {
        shapeLayer?.frame = bounds
        let path = UIBezierPath(ovalIn: bounds)
        path.move(to: CGPoint(x: bounds.midX + holeRadius, y: bounds.midY))
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: holeRadius,
                    startAngle: 0, endAngle: .pi * 2, clockwise: true)
        shapeLayer?.path = path.cgPath
    }

    private func getCurrentStep(onTouch touch: UITouch) -> Int {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let currentPoint = touch.location(in: self)
        return 0
    }

}
