//
//  Float+Extensions.swift
//  Pact
//
//  Created by Jake Goodman on 6/2/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import Foundation

extension Float {
    var isInteger: Bool {
        return truncatingRemainder(dividingBy: 1) == 0
    }
    func asInteger()->Int {
        return Int(self)
    }
}
