//
//  SemiCircleView.swift
//  Pact
//
//  Created by Jake Goodman on 6/2/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class SemiCirleView: UIView {
    
    var semiCirleLayer: CAShapeLayer!
    var borderLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if semiCirleLayer == nil {
            
            
            let arcCenter = CGPoint(x: bounds.size.width / 2, y: bounds.size.height)
            
            let circleRadius = bounds.size.width / 2
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
            
            semiCirleLayer = CAShapeLayer()
            semiCirleLayer.path = circlePath.cgPath
            semiCirleLayer.fillColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0).cgColor
            
            layer.addSublayer(semiCirleLayer)

            // Make the view color transparent
            backgroundColor = UIColor.clear
        }
        if borderLayer == nil {
            
            let arcCenter = CGPoint(x: bounds.size.width / 2, y: bounds.size.height)
            let borderRadius = (bounds.size.width / 2.0) + 1
            let borderPath  = UIBezierPath(arcCenter: arcCenter, radius: borderRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)

            
            borderLayer = CAShapeLayer()
            
            borderLayer.path = borderPath.cgPath
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.borderColor = UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0).cgColor
            borderLayer.borderWidth = 1.0
            borderLayer.lineWidth = 1.0
            borderLayer.strokeColor = UIColor(red:0.70, green:0.70, blue:0.70, alpha:1.0).cgColor
            layer.addSublayer(borderLayer)

         }
    }
    
    private func addSemiCircleLayer(at: CGPoint, radius: CGFloat) {
        
    }
}
