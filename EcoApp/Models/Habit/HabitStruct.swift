//
//  HabitStruct.swift
//  EcoApp
//
//  Created by Artem on 29.05.2021.
//

import Foundation
import ParseSwift

struct Habit: ParseObject {
    
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    
    var name: String?
    var desc: String?
    var points: Int? // сколько балов начислится пользователю, когда он выполнит привычку
    var frequency: Int? // как часто (через сколько дней) привычка будет появляться в чеклисте
    var photo: ParseFile?

}


extension Habit {
    func saveHabit() {
        guard let objectId = objectId else {
            assert(false)
            return
        }
        
        let model: HabitModel
        if let m: HabitModel = db.getObjects(withId: objectId, limit: 1).first {
            model = m
        } else {
            model = db.createNew()
        }
        model.objectId = objectId
        model.createdAt = createdAt
        model.updatedAt = updatedAt
        model.name = name
        model.desc = desc
        model.points = points as NSNumber?
        model.photoUrl = photo?.url?.absoluteString
        
    }
}
