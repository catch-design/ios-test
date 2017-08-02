//
//  ItemsViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    var manager: ItemsViewControllerManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = ItemsViewControllerManager()
        manager?.delegate = self
        tableView.delegate = manager
        tableView.dataSource = manager
        manager?.fetchItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailViewController, let item = sender as? Item {
                controller.item = item
            }
        }
    }
}

extension ItemsViewController: ItemsManagerProtocol {
    func itemsDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func userDidSelect(_ item: Item) {
        performSegue(withIdentifier: "Detail", sender: item)
    }
}
