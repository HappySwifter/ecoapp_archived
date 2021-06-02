//
//  Login+UserPass.swift
//  EcoApp
//
//  Created by Artem on 29.05.2021.
//

import Foundation
import ParseSwift

extension LoginViewController {
    
    @IBAction func loginPressed() {
        guard let login = loginField.text else {
            return
        }
        guard let pass = passField.text else {
            return
        }
        makeLogin(name: login, pass: pass)
    }
    
    @IBAction func adminLoginPressed() {
        makeLogin(name: "admin", pass: "4960_JimW")
    }
    
    @IBAction func testLoginPressed() {

        makeLogin(name: "test", pass: "test")
    }
    
    func makeLogin(name: String, pass: String) {
        User.login(username: name, password: pass) { [weak self] results in

            switch results {
            case .success(let user):

                guard let currentUser = User.current else {
                    assertionFailure("Error: current user currently not stored locally")
                    return
                }
                assert(currentUser.hasSameObjectId(as: user))
                print("Successfully logged in as user: \(user)")
                self?.routeToHabitList()

            case .failure(let error):
                print("Error logging in: \(error)")
            }
        }
    }
}
