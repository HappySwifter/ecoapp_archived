//
//  InterfaceController.swift
//  watch Extension
//
//  Created by Artem on 28.04.2021.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        print("!!")
        // Configure interface objects here.
    }
    
    override func willActivate() {
        print(">>")
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        print("<<")
        // This method is called when watch view controller is no longer visible
    }

}
