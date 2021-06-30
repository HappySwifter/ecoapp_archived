//
//  Checklist.swift
//  EcoApp
//
//  Created by Artem on 06.06.2021.
//

import Foundation
import ParseSwift

struct Checklist: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    
    var habit: Habit?
    var user: User?
    var frequency: Int?
    var lastFactDate: Date?
    var isCompleted: Bool
}

