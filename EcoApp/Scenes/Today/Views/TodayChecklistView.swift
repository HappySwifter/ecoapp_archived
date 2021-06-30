//
//  TodayChecklistView.swift
//  EcoApp
//
//  Created by Artem on 20.06.2021.
//

import Foundation
import UIKit

class TodayChecklistView: UIView {
    @IBOutlet private weak var counterLabel: UILabel!
    private var checklist = [Checklist]()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        counterLabel.text = ""
    }
    
    
    func configure(with checklist: [Checklist]) {
        self.checklist = checklist
        refresh()
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
        let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: start)!
        let end = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: end)!
        return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
    }

    func canMakeCheck(check: Checklist) -> Bool {
        print("----", check.habit?.name ?? "", check.objectId ?? 0)
        guard let lastFactDate = check.lastFactDate else {
            print("без факта - показываем")
            return true
        }
        print("----", lastFactDate, check.frequency!)

        let checkDateWithFr = lastFactDate.addDays(check.frequency!)
        let daysDiff = daysBetween(start: Date(), end: checkDateWithFr)
        if daysDiff <= 0 {
            print("разница меньше 0 - показываем")
            return true
        } else if daysDiff > 0 {
            print("разница больше 0 - Не показываем")
            return false
        } else {
            print("разница 0 - показываем")
            return true
        }
    }
    
    func isCheckForToday(check: Checklist) -> Bool {
        guard let lastFactDate = check.lastFactDate else {
            Log("привычка без факта, показываем в сегодня", type: .info)
            return true
        }
        if check.createdAt!.isToday {
            Log("привычка была добавлена в этот день, показываем", type: .info)
            return true
        }
        if lastFactDate.isToday {
            Log("факт был проставлен сегодня, показываем", type: .info)
            return true
        }
        let checkDateWithFr = lastFactDate.addDays(check.frequency!)
        if checkDateWithFr.isToday || checkDateWithFr <= check.createdAt! {
            Log("привычка назначена на сегодня, показываем", type: .info)
            return true
        } else {
            Log("привычка Не на сегодня. Покажется: \(checkDateWithFr.fullDateString()). \(lastFactDate.fullDateString()) + \(check.frequency ?? 0)", type: .info)
            return false
        }
    }
    

    
    func refresh() {
        for check in checklist {
//            assert(isCheckForToday(check: check) == true)
            assert(canMakeCheck(check: check) == !check.isCompleted)
        }
        let makeTodayCounter = checklist.filter{ $0.isCompleted }.count
        counterLabel.text = "\(makeTodayCounter)/\(checklist.count)"
    }
}

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}
