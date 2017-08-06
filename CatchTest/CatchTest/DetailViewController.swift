//
//  DetailViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 02/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

/**
 Presents the details about an item that the user selected from the list
 */
class DetailViewController: UIViewController {
    ///Where we display the detail description
    @IBOutlet fileprivate weak var detailDescriptionText: UITextView!
    ///The model for the controller
    var item: Item?
    
    //in a real world scenario this controller will have its own manager object
    //but for the purpouses of this excersise the simple Item struct is enough
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let's map the model to the UI
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
