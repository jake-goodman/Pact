//
//  UIView+Extensions.swift
//  Pact
//
//  Created by Jake Goodman on 6/2/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

extension UIView {
    func displayAsCircle() {
        layer.cornerRadius = bounds.width/2.0
        layer.masksToBounds = true
    }
    
    func showBorder(width: CGFloat, color: CGColor) {
        layer.borderColor = color
        layer.borderWidth = width
    }
}

