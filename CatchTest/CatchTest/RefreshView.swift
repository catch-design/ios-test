//
//  RefreshView.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 04/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

/**
 Provides the custom UI for the refresh control
 */
class RefreshView: UIView {
    
    //I would have made the animation myself, but thought bonus points for using Cocoapods
    
    @IBOutlet fileprivate weak var activityIndicatorView: NVActivityIndicatorView!
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
    
}
