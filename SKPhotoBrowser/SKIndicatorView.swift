//
//  SKIndicatorView.swift
//  SKPhotoBrowser
//
//  Created by StasMagic on 03.12.2020.
//  Copyright © 2020 suzuki_keishi. All rights reserved.
//

import Foundation
import UIKit

final class SKIndicatorView: UIView {
    
    var lineWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var backLayerColor: UIColor = UIColor(red: 0.179, green: 0.179, blue: 0.179, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var fronLayerColor: UIColor = UIColor.white {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var indicatorSize: CGFloat = 32 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    private let backLayer = CAShapeLayer()
    private let frontLayer = CAShapeLayer()
    private var circleRadius: CGFloat {
        (indicatorSize / 2) - (lineWidth / 2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    private func setupUI() {
        addLayer(backLayer)
        addLayer(frontLayer)
        hide()
        isUserInteractionEnabled = false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupFrontLayer()
    }
    
    func startAnimating() {
        addAnimation()
        show()
    }
    
    func stopAnimating() {
        frontLayer.removeAllAnimations()
        hide()
    }
    
    private func show() {
        frontLayer.isHidden = false
        backLayer.isHidden = false
    }
    
    private func hide() {
        frontLayer.isHidden = true
        backLayer.isHidden = true
    }
    
    private func addLayer(_ newLayer: CAShapeLayer) {
        layer.addSublayer(newLayer)
        newLayer.fillColor = UIColor.clear.cgColor
        newLayer.lineWidth = lineWidth
        newLayer.frame = bounds
    }
    
    private func setupFrontLayer() {
        let newX = center.x - (indicatorSize / 2)
        let newY = center.y - (indicatorSize / 2)
        let newLayerFrame = CGRect(origin: CGPoint(x: newX, y: newY),
                                   size: CGSize(width: indicatorSize, height: indicatorSize))
        let circleCenter = CGPoint(x:indicatorSize / 2 , y: indicatorSize / 2)
        
        let circlePath = UIBezierPath(arcCenter: circleCenter,
                                      radius: circleRadius,
                                      startAngle: CGFloat(4),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        frontLayer.frame = newLayerFrame
        frontLayer.path = circlePath.cgPath
        frontLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        frontLayer.lineWidth = lineWidth
        frontLayer.strokeColor = fronLayerColor.cgColor
        
        let backCirclePath = UIBezierPath(arcCenter: circleCenter,
                                      radius: circleRadius,
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        backLayer.frame = newLayerFrame
        backLayer.path = backCirclePath.cgPath
        backLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backLayer.lineWidth = lineWidth
        backLayer.strokeColor = backLayerColor.cgColor
    }
    
    private func addAnimation() {
        let spining = CABasicAnimation(keyPath: "transform.rotation")
        spining.duration = 1
        spining.repeatCount = .greatestFiniteMagnitude
        spining.fillMode = .forwards
        spining.fromValue = 0
        spining.toValue = 2 * CGFloat.pi
        frontLayer.add(spining, forKey: "spining")
    }
    
}
