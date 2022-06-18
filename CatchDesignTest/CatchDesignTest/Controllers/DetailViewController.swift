//
//  DetailViewController.swift
//  CatchDesignTest
//
//  Created by Shafee Rehman on 18/06/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var contentLabel: UILabel!
    var content: String?
    var modelTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = modelTitle
        contentLabel.text = content
    }
    

}
