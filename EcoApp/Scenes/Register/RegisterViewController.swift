//
//  RegisterViewController.swift
//  EcoApp
//
//  Created by Artem on 21.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RegisterDisplayLogic: class
{
    func displaySomething(viewModel: Register.Something.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic
{
    var interactor: RegisterBusinessLogic?
    var router: (NSObjectProtocol & RegisterRoutingLogic & RegisterDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    
    func displaySomething(viewModel: Register.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    @IBAction func registerTouched() {
        guard let login = loginTextField.text, let pass = passwordTextField.text else {
            return
        }
        interactor?.registerUser(with: login, password: pass) { result in
            switch result {
            case .success(let user):
                guard let currentUser = User.current else {
                    assertionFailure("Error: current user currently not stored locally")
                    return
                }
                if !currentUser.hasSameObjectId(as: user) {
                    assertionFailure("Error: these two objects should match")
                } else {
                    print("Successfully signed up user \(user)")
                }

            case .failure(let error):
                assertionFailure("Error signing up \(error)")
            }
        }
    }
}
