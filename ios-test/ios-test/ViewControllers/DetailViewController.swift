//
//  DetailViewController.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    var dataModel: DataModel?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        guard let dataModel = dataModel else {
            return
        }
        configure(with: dataModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

        // Make sure the textview clears the nav bar on iOS 10.
        edgesForExtendedLayout = []
    }

    // MARK: - View helpers

    private func configureView() {
        textView.isEditable = false
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.midGrey.cgColor
        textView.textContainerInset = UIEdgeInsets(top: 24, left: 10, bottom: 24, right: 10)
    }

    private func configure(with data: DataModel) {
        title = data.title?.capitalized
        textView.text = data.content
    }

}
