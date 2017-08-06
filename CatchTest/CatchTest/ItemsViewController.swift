//
//  ItemsViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ItemsViewController: UIViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    var manager: ItemsViewControllerManager?
    
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var customRefreshView: RefreshView!
    
    fileprivate func registerNibs() {
        tableView.register(UINib(nibName: ItemTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupManager()
        setupTableView()
        setupRefreshControl()
    }
    
    fileprivate func setupRefreshControl() {
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
    
    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "CatchLogo"))
        imageView.contentMode = .scaleAspectFit
        tableView.backgroundView = imageView
        let viewsDictionary: [String: Any] = ["imageView": imageView]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView]-|", options: [], metrics: nil, views: viewsDictionary))
        NSLayoutConstraint.activate([NSLayoutConstraint(item: tableView, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0)])
    }
    
    fileprivate func setupManager() {
        manager = ItemsViewControllerManager()
        manager?.delegate = self
        tableView.delegate = manager
        tableView.dataSource = manager
        manager?.fetchItems()
    }
    
    fileprivate func customizeRefreshControl() {
        if let view: RefreshView = RefreshView.loadFromNib() {
            customRefreshView = view
            customRefreshView?.frame = refreshControl.bounds
            refreshControl.addSubview(customRefreshView!)
            let viewsDictionary: [String: Any] = ["customRefresh": customRefreshView]
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[customRefresh]|", options: [], metrics: nil, views: viewsDictionary))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[customRefresh]|", options: [], metrics: nil, views: viewsDictionary))
        }
    }
    
    @objc private func refreshData(sender: Any?) {
        customRefreshView.startAnimating()
        manager?.fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailViewController, let item = sender as? Item {
                controller.item = item
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
