//
//  BaseViewController.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 19/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let className = String(describing: type(of: self))
        ErrorManager.trackOpenView(className: className)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.Black.tone3

    }
}
