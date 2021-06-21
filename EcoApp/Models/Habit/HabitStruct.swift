//
//  HabitStruct.swift
//  EcoApp
//
//  Created by Artem on 29.05.2021.
//

import Foundation
import ParseSwift


struct Habit: ParseObject, Hashable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.objectId == rhs.objectId &&
        lhs.isLiked == rhs.isLiked &&
        lhs.ACL == rhs.ACL &&
        lhs.name == rhs.name &&
        lhs.points == rhs.points &&
        lhs.difficulty == rhs.difficulty &&
        lhs.category == rhs.category &&
        lhs.photo == rhs.photo
    }
    
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    
    var name: String?
    var desc: String?
    var points: Int? // сколько балов начислится пользователю, когда он выполнит привычку
    var frequency: Int? // как часто (через сколько дней) привычка будет появляться в чеклисте
    var difficulty: Int? // сложность привычки
    var category: HabitCategory?
    var photo: ParseFile?
    
    var isLiked: Bool?
    var lastFactDate: Date?
    
    var difficultyEnum: HabitDifficulty? {
        guard let difficulty = difficulty else {
            return nil
        }
        return HabitDifficulty(rawValue: difficulty)
    }
    
    func hasLike(likes: [Checklist]) -> Bool {
        likes.contains{ $0.habit?.objectId == objectId }
    }
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
        model.difficulty = difficulty as NSNumber?
    }
}
