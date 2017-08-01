//
//  DetailWireframe.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

let DetailViewControllerIdentifier = "DetailViewController"

class DetailWireframe: BaseWireframe {
    func showDetailViewController(_ dataEntity: DataEntity, from sender: UIViewController) {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailViewControllerIdentifier) as! DetailViewController
        viewController.data = dataEntity
        
        sender.navigationController?.show(viewController, sender: sender)
    }
}
