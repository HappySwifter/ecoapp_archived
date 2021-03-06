//
//  ChecklistDetailsPresenter.swift
//  Ecobalance life
//
//  Created by Artem on 24.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChecklistDetailsPresentationLogic
{
    func presentSomething(response: ChecklistDetails.Something.Response)
}

class ChecklistDetailsPresenter: ChecklistDetailsPresentationLogic
{
    weak var viewController: ChecklistDetailsDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: ChecklistDetails.Something.Response)
    {
        let viewModel = ChecklistDetails.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
