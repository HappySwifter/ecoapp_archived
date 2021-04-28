//
//  UIviewController+Ext.swift
//  EcoApp
//
//  Created by Artem on 28.04.2021.
//

import Foundation
import UIKit

extension UIViewController {



}

func getController<T>(forName name: T.Type) -> T {
    let story = UIStoryboard(name: String(describing: name), bundle: Bundle.main)
    let contr = story.instantiateViewController(withIdentifier: String(describing: name))
//    contr.modalPresentationStyle = .formSheet
//    if #available(iOS 13.0, *) {
//        contr.isModalInPresentation = true
//    }
    return contr as! T
}
