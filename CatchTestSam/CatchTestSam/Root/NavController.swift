//
//  NavController.swift
//  CatchTestSam
//
//  Created by smoriyasu on 25/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit

class NavController: UINavigationController, UINavigationControllerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.delegate = self;
    }
	
	override var prefersStatusBarHidden: Bool {
		get {
			return false
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self.viewControllers.first {
            self.setNavigationBarHidden(true, animated: animated)
        } else {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}
