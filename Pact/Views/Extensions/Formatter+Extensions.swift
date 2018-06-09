//
//  Formatter+Extensions.swift
//  Pact
//
//  Created by Jake Goodman on 6/3/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
