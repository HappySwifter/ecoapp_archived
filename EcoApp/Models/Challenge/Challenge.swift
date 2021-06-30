//
//  Challenge.swift
//  EcoApp
//
//  Created by Artem on 27.06.2021.
//

import Foundation
import ParseSwift

struct Habit2Challenge: Codable {
    var habitId: String?
    var targetDate: Date
}

struct Challenge: ParseObject, Hashable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.objectId == rhs.objectId &&
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.ACL == rhs.ACL &&
        lhs.name == rhs.name &&
        lhs.desc == rhs.desc
//            &&
//        lhs.lastFactDate == rhs.lastFactDate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(objectId)
    }
    
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var name: String?
    var desc: String?
    
    var isParticipating: Bool?
    var habits: [Habit2Challenge]?
}
