//
//  AppUtility.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class AppUtility {
    
    static func presentSimpleAlert(on viewController: UIViewController, title: String?, message: String?, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
