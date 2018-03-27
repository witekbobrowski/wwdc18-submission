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

    var recentStateChange: ScrollWheelStateChange? { didSet { sendActions(for: .valueChanged) } }
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
        guard let current = getCurrentStep(onTouch: touch) else { return false }
        guard let previous = currentStep else {
            currentStep = current
            return true
        }
        evaluateMovement(from: previous, to: current)
        isTouched = true
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let current = getCurrentStep(onTouch: touch) else { return false }
        guard let previous = currentStep else {
            currentStep = current
            return true
        }
        evaluateMovement(from: previous, to: current)
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        currentStep = nil
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

    private func getCurrentStep(onTouch touch: UITouch) -> Int? {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let currentPoint = touch.location(in: self)
        guard let angle = convertToPolarCoordinates(x: currentPoint.x-center.x, y: currentPoint.y-center.y) else {
            return nil
        }
        return Int(floor(angle / (CGFloat.pi * 2 / CGFloat(numberOfSteps))))
    }

    private func evaluateMovement(from current: Int, to next: Int) {
        guard current != next else { return }
        if current < next,
            (0...numberOfSteps/4).contains(current),
            (numberOfSteps-(numberOfSteps/4)...numberOfSteps).contains(next) {
            (next...current+numberOfSteps).forEach { _ in recentStateChange = .previous }
        } else if current < next {
            (current...next).forEach { _ in recentStateChange = .next }
        } else if (0...numberOfSteps/4).contains(next),
            (numberOfSteps-(numberOfSteps/4)...numberOfSteps).contains(current) {
            (current...next+numberOfSteps).forEach { _ in recentStateChange = .next }
        } else {
            (next...current).forEach { _ in recentStateChange = .previous }
        }
        currentStep = next
    }

    private func convertToPolarCoordinates(x: CGFloat, y: CGFloat) -> CGFloat? {
        var result: CGFloat
        if x == 0, y == 0 {
            return nil
        } else if x > 0 {
            result = atan(y/x)
        } else if x < 0, y >= 0 {
            result = atan(y/x) + .pi
        } else if x < 0, y < 0 {
            result = atan(y/x) - .pi
        } else if x == 0, y > 0 {
            result = .pi/2
        } else { // if x == 0, y < 0
            result = -.pi/2
        }
        // Change scale from (-𝝅;𝝅] to [0;2𝝅)
        return result < 0 ? result + .pi * 2 : result
    }

}
