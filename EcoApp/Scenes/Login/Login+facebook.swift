//
//  Login+facebook.swift
//  EcoApp
//
//  Created by Artem on 28.04.2021.
//

import Foundation
import ParseSwift
import FBSDKLoginKit

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton,
                     didCompleteWith result: LoginManagerLoginResult?,
                     error: Error?) {
        print(error)
        switch result {
        case .some(let res):
            guard let authToken = res.authenticationToken?.tokenString, let token = res.token?.tokenString, let userId = res.token?.userID else {
                return
            }
            
            print(AuthenticationToken.current?.tokenString)
            print("\n")
            print(AccessToken.current?.tokenString)
            
            let parse = ParseFacebook<User>()
            
            if let token = AuthenticationToken.current {
                parse.login(userId: userId, authenticationToken: token.tokenString) {
                        [weak self] (result) in
                            switch result {
                            case .success(let user):
                                self?.routeToHabitList()
                            case .failure(let error):
                                print(error)
                            }
                }
                
            }
            
//            if let token = AccessToken.current,
//                    !token.isExpired {
//                    
//                parse.login(userId: userId, accessToken: token.tokenString) {
//                        [weak self] (result) in
//                            switch result {
//                            case .success(let user):
//                                self?.routeToHabitList()
//                            case .failure(let error):
//                                print(error)
//                            }
//                    }
//                
//                }
            
            
        
//            parse.login(userId: userId, authenticationToken: token) { [weak self] (result) in
//                switch result {
//                case .success(let user):
//                    self?.routeToHabitList()
//                case .failure(let error):
//                    print(error)
//                }
//            }
//
//            parse.login(userId: userId, accessToken: authToken) {
//                [weak self] (result) in
//                    switch result {
//                    case .success(let user):
//                        self?.routeToHabitList()
//                    case .failure(let error):
//                        print(error)
//                    }
//            }
//
//            parse.login(userId: userId, authenticationToken: authToken) { [weak self] (result) in
//                switch result {
//                case .success(let user):
//                    self?.routeToHabitList()
//                case .failure(let error):
//                    print(error)
//                }
//            }
        default:
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        try? User.logout()
    }
    

}
