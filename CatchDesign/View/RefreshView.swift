//
//  RefreshView.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 19/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class RefreshView: UIView {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func startAnimation() {
        indicator.startAnimating()
    }
    
    func endAnimation() {
        indicator.stopAnimating()
    }
}
