//
//  HabitCategory.swift
//  EcoApp
//
//  Created by Artem on 18.06.2021.
//

import Foundation
import ParseSwift

struct HabitCategory: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    
    var name: String?
    var group: HabitGroup?
}
