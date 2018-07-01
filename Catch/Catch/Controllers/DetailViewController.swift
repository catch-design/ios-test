//
//  DetailViewController.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    var content: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let content = content else {
            centerContentWith(message: "No Data Available")
            return
        }
        contentTextView.text = content
    }
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
    
    func centerContentWith(message: String) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        contentTextView.attributedText = NSAttributedString(string: message,
                                                            attributes: [.paragraphStyle: paragraph])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
}
