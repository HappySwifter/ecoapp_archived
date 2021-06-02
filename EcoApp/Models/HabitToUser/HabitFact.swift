//
//  HabitFact.swift
//  EcoApp
//
//  Created by Artem on 30.05.2021.
//

import Foundation
import ParseSwift

struct HabitFact: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    
    var habit: Habit?
    var user: User?
    var points: Int?
    
}
