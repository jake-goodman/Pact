//
//  ActivityLog.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import Foundation

class ActivityLog {
    var id: String
    var numHours: Float
    var description: String
    
    init(id: String, numHours: Float, description: String) {
        self.id = id
        self.numHours = numHours
        self.description = description
    }
    
    func toJSON() -> [String: Any] {
        return ["id": id,
                "numHours": numHours,
                "description": description]
    }
}
