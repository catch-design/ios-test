//
//  ListWireframe.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

let ListTableViewControllerIdentifier = "ListTableViewController"

class ListWireframe: BaseWireframe {
    var listPresenter : ListPresenter?
    var listViewController : ListTableViewController?
    var detailWireframe: DetailWireframe?
    
    func presentListInterfaceFromWindow(_ window: UIWindow) {
        let viewController = listViewControllerFromStoryboard()
        viewController.eventHandler = listPresenter
        listViewController = viewController
        listPresenter!.listInterface = viewController
        self.showRootViewController(viewController, inWindow: window)
    }
    
    func showDetailViewController(_ data: DataEntity, from sender: UIViewController) {
        detailWireframe?.showDetailViewController(data, from: sender)
    }
    
    func listViewControllerFromStoryboard() -> ListTableViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ListTableViewControllerIdentifier) as! ListTableViewController
        return viewController
    }
}
