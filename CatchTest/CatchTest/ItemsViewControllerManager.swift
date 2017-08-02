//
//  ItemsViewControllerManager.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

protocol ItemsManagerProtocol: class {
    func itemsDidUpdate()
    func userDidSelect(_ item: Item)
}

class ItemsViewControllerManager: NSObject {
    var items = [Item]() {
        didSet {
            delegate?.itemsDidUpdate()
        }
    }
    
    weak var delegate: ItemsManagerProtocol?
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userDidSelect(items[indexPath.row])
    }
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
