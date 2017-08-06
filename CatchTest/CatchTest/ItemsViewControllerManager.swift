//
//  ItemsViewControllerManager.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

//This is how we notify whoevere is interested about events in our lifecycle
protocol ItemsManagerProtocol: class {
    ///The items did just update
    func itemsDidUpdate()
    
    /**
     The user selected an item
     
     - Parameters:
        - item: The item the user selected
     
     */
    func userDidSelect(_ item: Item)
}

class ItemsViewControllerManager: NSObject {
    ///Storage for the items we get from the server
    var items = [Item]() {
        didSet {
            //we just did update
            //let the world know
            delegate?.itemsDidUpdate()
        }
    }
    
    ///Who is listening on the channel
    weak var delegate: ItemsManagerProtocol?
    
    ///Get the data
    func fetchItems() {
        NetworkAssistant.shared.fetchItems(from: itemsURL) { (items) in
            guard let items = items else {
                return
            }
            //only if we have valid response do we assign to our storage
            self.items = items
        }
    }
}

extension ItemsViewControllerManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //the user just tapped on an item
        //scramble for the details
        delegate?.userDidSelect(items[indexPath.row])
    }
}

extension ItemsViewControllerManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //how many rows = how many items
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemTableViewCell
        //the model of each cell will be made out of a single item (mapping) form the storage
        //The case is trivial, but imagine a more complex app
        cell?.model = ItemCellManager(item: items[indexPath.row])
        
        return cell!
    }
}
