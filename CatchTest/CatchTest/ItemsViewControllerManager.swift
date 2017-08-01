//
//  ItemsViewControllerManager.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

class ItemsViewControllerManager: NSObject {
    var items = [Item]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func fetchItems() {
        NetworkAssistant.shared.fetchItems(from: itemsURL) { (items) in
            guard let items = items else {
                return
            }
            self.items = items
        }
    }
}

extension ItemsViewControllerManager: UITableViewDelegate {
    
}

extension ItemsViewControllerManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].subtitle
        return cell
    }
}
