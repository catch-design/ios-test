//
//  AlertController.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import Foundation

import UIKit

enum AlertType {
    case success
    case failure
}

/// Generic AlertView
///
/// - Parameters:
///   - titleType: Success or Failure
///   - message: Alert message to display
///   - handler: Alert custom action
/// - Returns: Alert Controller
struct Alert {
    static func showAlert(ofType titleType: AlertType, message:String, handler: ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        
        var title: String
        switch titleType {
        case .success:
            title = "Successful"
        case .failure:
            title = "Error!"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: handler))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        
        return alert
    }
}

