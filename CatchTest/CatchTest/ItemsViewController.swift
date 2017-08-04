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
    
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var customRefreshView: RefreshView!
    
    fileprivate func registerNibs() {
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ItemCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        manager = ItemsViewControllerManager()
        manager?.delegate = self
        tableView.delegate = manager
        tableView.dataSource = manager
        manager?.fetchItems()
        
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(ItemsViewController.refreshData(sender:)), for: .valueChanged)
        customizeRefreshControl()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        else {
            tableView.addSubview(refreshControl)
        }
        
    }
    
    fileprivate func customizeRefreshControl() {
        let customRefresh = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)
        customRefreshView = customRefresh?.first as? RefreshView
        customRefreshView.frame = refreshControl.bounds
        //customRefreshView.setupView()
        refreshControl.addSubview(customRefreshView)
    }
    
    @objc private func refreshData(sender: Any?) {
        customRefreshView.startAnimating()
        manager?.fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
            self.refreshControl.endRefreshing()
            self.customRefreshView.stopAnimating()
        }
    }
    
    func userDidSelect(_ item: Item) {
        performSegue(withIdentifier: "Detail", sender: item)
    }
}
