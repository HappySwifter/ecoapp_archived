//
//  TabBarVC.swift
//  EcoApp
//
//  Created by Artem on 20.06.2021.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for contr in viewControllers ?? [] {
            guard let nav = contr as? UINavigationController else {
                continue
            }
            if let today = nav.viewControllers.first as? TodayViewController {
                today.title = "Сегодня"
            }
            if let habitList = nav.viewControllers.first as? HabitListViewController {
                habitList.title = "Привычки"
            }
        }
    }
}
