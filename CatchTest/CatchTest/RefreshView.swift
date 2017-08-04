//
//  RefreshView.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 04/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RefreshView: UIView {
    
    @IBOutlet fileprivate weak var activityIndicatorView: NVActivityIndicatorView!
    
    /*func setupView() {
        activityIndicatorView.type = .ballClipRotate
    }*/
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }

}
