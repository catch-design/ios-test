//
//  ContentViewController.swift
//  CatchTestSam
//
//  Created by smoriyasu on 26/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

	var record : Record?;
	
	@IBOutlet var contentTextView: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		contentTextView.text = record?.content;
		title = record?.title;
    }
}
