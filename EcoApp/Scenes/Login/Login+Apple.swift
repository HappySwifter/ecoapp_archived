//
//  Login+Apple.swift
//  EcoApp
//
//  Created by Artem on 28.04.2021.
//

import Foundation
import ParseSwift

extension LoginViewController {
    func makeAppleLogin(id: String, token: Data, fullName: PersonNameComponents?, email: String?) {
        let parse = ParseApple<User>()
        parse.login(user: id, identityToken: token) { [weak self] (result) in
            switch result {
            case .success(let user):
                print(user)
                print(">>", User.current)
                self?.routeToHabitList()
            case .failure(let error):
                print(error)
            }
        }
    }
}
