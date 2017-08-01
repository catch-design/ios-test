//
//  ItemsViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var manager: ItemsViewControllerManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = ItemsViewControllerManager(tableView: tableView)
        tableView.delegate = manager
        tableView.dataSource = manager
        manager?.fetchItems()
    }

}
