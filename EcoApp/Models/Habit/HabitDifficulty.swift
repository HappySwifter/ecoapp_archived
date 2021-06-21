//
//  HabitDifficulty.swift
//  EcoApp
//
//  Created by Artem on 18.06.2021.
//

import Foundation

enum HabitDifficulty: Int, CustomStringConvertible {
    case easy
    case medium
    case hard
    
    var description: String {
        switch self {
        case .easy:
            return "Легко"
        case .medium:
            return "Средне"
        case .hard:
            return "Сложно"
        }
    }
}
