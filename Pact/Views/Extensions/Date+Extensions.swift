//
//  UIDate+Extensions.swift
//  Pact
//
//  Created by Jake Goodman on 6/3/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import Foundation

extension Date {
    var monthDayString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d") // set template after setting locale
        return dateFormatter.string(from: self
        )
    }
    var monthDayYearString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d YYYY") // set template after setting locale
        return dateFormatter.string(from: self
        )
    }
}
