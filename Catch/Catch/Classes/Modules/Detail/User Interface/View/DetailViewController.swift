//
//  DetailViewController.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var data: DataEntity?
    
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.title = data?.title?.capitalizingFirstLetter()
        self.contentTextView.text = data?.content
        // to make sure everytime that enters the viewcontroller, the textview shows from the start
        self.contentTextView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
