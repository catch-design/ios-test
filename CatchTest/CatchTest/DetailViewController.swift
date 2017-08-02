//
//  DetailViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 02/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var detailDescriptionText: UITextView!
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = item?.title
        detailDescriptionText.text = item?.content
    }


}
