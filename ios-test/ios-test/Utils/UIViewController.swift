//
//  UIViewController.swift
//  ios-test
//
//  Created by Dean Woodward on 5/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showSimpleAlert(error: Error?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Network Error",
                                      message: error?.localizedDescription ?? "An network error occurred",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
