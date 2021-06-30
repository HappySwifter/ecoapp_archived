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
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.ACL == rhs.ACL &&
        lhs.name == rhs.name &&
        lhs.desc == rhs.desc &&
        lhs.points == rhs.points &&
        lhs.difficulty == rhs.difficulty &&
        lhs.frequency == rhs.frequency &&
        lhs.category == rhs.category &&
        lhs.photo == rhs.photo &&
        lhs.isLiked == rhs.isLiked
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
    var points: Int? // сколько балов начислится пользователю, когда он выполнит привычку
    var frequency: Int? // как часто (через сколько дней) привычку можно выполнять повторно
    var difficulty: Int? // сложность привычки
    var category: HabitCategory?
    var photo: ParseFile?
    var isLiked: Bool?
    var challenges: [Challenge]?
    
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
//        model.ACL = ACL
        model.name = name
        model.desc = desc
        model.points = points as NSNumber?
        model.frequency = frequency as NSNumber?
        model.difficulty = difficulty as NSNumber?
//        model.category = category
        model.photoUrl = photo?.url?.absoluteString
        model.isLiked = isLiked ?? false
//        model.lastFactDate = lastFactDate

    }
}

extension HabitModel {
    func getStruct() -> Habit {
        var file: ParseFile?
        if let photoUrl = photoUrl {
            file = ParseFile(cloudURL: URL(string: photoUrl)!)
        }
        
        return Habit(objectId: objectId,
              createdAt: createdAt,
              updatedAt: updatedAt,
              ACL: nil,
              name: name,
              desc: desc,
              points: points?.intValue,
              frequency: frequency?.intValue,
              difficulty: difficulty?.intValue,
              category: nil,
              photo: file,
              isLiked: isLiked
//              ,
//              lastFactDate: lastFactDate
        )
    }
}
