//
//  DetailViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 02/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet fileprivate weak var detailDescriptionText: UITextView!
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = item?.title
        detailDescriptionText.text = item?.content
        detailDescriptionText.backgroundColor = UIColor(white: cellBackgroundColor, alpha: 0.97)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }


}
