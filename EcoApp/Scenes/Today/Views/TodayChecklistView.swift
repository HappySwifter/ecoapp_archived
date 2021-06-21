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
    
    
    func refresh() {
        var makeTodayCounter = checklist.count
        for check in checklist {
            if let lastCheckDate = check.lastCheckDate {
                let date = lastCheckDate.addDays(check.frequency!)
                if date < Date() {
                    makeTodayCounter -= 1
                }
            } else {
                makeTodayCounter -= 1
            }
        }
        counterLabel.text = "\(makeTodayCounter)/\(checklist.count)"
    }
}
