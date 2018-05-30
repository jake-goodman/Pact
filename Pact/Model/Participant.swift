//
//  Participant.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import Foundation
struct MappingError: Error {
}

class Participant {
    var id: String
    var name: String
    var logs: [ParticipationLog] = []
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(json: [String: Any]) throws {
        guard let id = json["id"] as? String, let name = json["name"] as? String else {
            throw MappingError()
        }
        self.id = id
        self.name = name
    }
    
    func toJSON()-> [String: Any] {
        return ["id": id,
                "name": name]
    }
}

class ParticipationLog {
    var id: String = ""
    var description: String = ""
    var numHours: Float = 0
    
}

class Event {
    var id: String = ""
    var name: String = ""
}
