//
//  Date+Extensions.swift
//  EcoApp
//
//  Created by Artem on 20.06.2021.
//

import Foundation

extension Date {
    var formatterShort: DateFormatter {
        let form = DateFormatter()
        form.dateFormat = "dd.MM.yyyy"
        return form
    }

    var formatterFull: DateFormatter {
        let form = DateFormatter()
        form.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return form
    }
    
    func shortDateString() -> String {
        return formatterShort.string(from: self)
    }
    
    func fullDateString() -> String {
        return formatterFull.string(from: self)
    }
}


