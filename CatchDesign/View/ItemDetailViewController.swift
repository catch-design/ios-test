//
//  ItemDetailViewController.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 18/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class ItemDetailViewController: BaseViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    private let presenter = ItemDetailPresenter()

    static func initViewController(item: Item?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController

        let presenter = viewController.presenter
        presenter.attachView(view: viewController)
        presenter.setItem(item: item)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadItem()
    }
    
    override func viewDidLayoutSubviews() {
         let customBackground = BackgroundView(frame: backgroundView.bounds)
        backgroundView.addSubview(customBackground)
    }
}

// MARK:- ItemDetailViewDelegate
extension ItemDetailViewController: ItemDetailViewDelegate {
    func showItem(title: String, content: String) {
        self.title = title
        contentTextView.text = content
    }
}
