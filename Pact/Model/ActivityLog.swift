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
    var dateLogged: Date
    var datePerformed: Date?
    var description: String
    
    init(id: String, numHours: Float, datePerformed: Date? = nil, description: String) {
        self.id = id
        self.numHours = numHours
        self.description = description
        self.datePerformed = datePerformed
        self.dateLogged = Date()
    }
    
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? String, let numHours = json["numHours"] as? Float, let description = json["description"] as? String, let dateLoggedString = json["dateLogged"] as? String else {
            throw MappingError()
        }
        self.id = id
        self.numHours = numHours
        self.description = description
        self.dateLogged = Date(iso8601String: dateLoggedString)
        if let datePerformedString = json["datePerformed"] as? String {
            self.datePerformed = Date(iso8601String: datePerformedString)
        }
    }
    
    func toJSON() -> [String: Any] {
        var json: [String: Any] = ["id": id,
                "numHours": numHours,
                "description": description,
                "dateLogged": dateLogged.iso8601String]
        if let datePerformed = datePerformed {
            json["datePerformed"] = datePerformed.iso8601String
        }
        return json
    }
}
