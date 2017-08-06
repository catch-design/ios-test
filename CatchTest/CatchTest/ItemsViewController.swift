//
//  ItemsViewController.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

/**
 Displays the data we fetch from the server.
 */
class ItemsViewController: UIViewController {
    ///The structure we use to present the individual items in the list we get from the server
    @IBOutlet fileprivate weak var tableView: UITableView!
    ///This object acts as a proxy to the table view delegate and data source, fetches the items from the server, parses them and notifies the view controller about events
    var manager: ItemsViewControllerManager?
    ///The pull to refresh control
    fileprivate let refreshControl = UIRefreshControl()
    ///This is how we customize the view
    fileprivate var customRefreshView: RefreshView!
    
    ///We have to register the custom cell before we can use it
    fileprivate func registerNibs() {
        //Notice how much more readable is this line once we conform to NibName and ReuseIdentifier protocols
        tableView.register(UINib(nibName: ItemTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: ItemTableViewCell.reuseIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The view is ready to be displayed
        //let's set up the scene
        
        registerNibs()
        setupManager()
        setupTableView()
        setupRefreshControl()
    }
    
    fileprivate func setupRefreshControl() {
        //we are going to have a custom refresh control
        //let's make sure we hide the original
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(ItemsViewController.refreshData(sender:)), for: .valueChanged)
        customizeRefreshControl()
        //there is a difference in how the refresh control works between iOS versions
        //we need to cope with that
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        }
        else {
            tableView.addSubview(refreshControl)
        }
    }
    
    fileprivate func setupTableView() {
        //we are going to use custom separators
        //hide the original ones
        tableView.separatorStyle = .none
        //love the new swift capabilities
        let imageView = UIImageView(image: #imageLiteral(resourceName: "CatchLogo"))
        imageView.contentMode = .scaleAspectFit
        tableView.backgroundView = imageView
        let viewsDictionary: [String: Any] = ["imageView": imageView]
        //make sure the logo is dead in the center
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView]-|", options: [], metrics: nil, views: viewsDictionary))
        NSLayoutConstraint.activate([NSLayoutConstraint(item: tableView, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1, constant: 0)])
    }
    
    fileprivate func setupManager() {
        //create our manager
        manager = ItemsViewControllerManager()
        //point to the delegate
        manager?.delegate = self
        //provide the delegate and data source for the table view
        tableView.delegate = manager
        tableView.dataSource = manager
        //where is my data
        manager?.fetchItems()
    }
    
    fileprivate func customizeRefreshControl() {
        //let's setup the custom refresh control
        
        //protocols for nice syntax again
        //and some extenstions as well
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
        //our user has requested a refresh
        //let's start the animation
        customRefreshView.startAnimating()
        //and where is my data again
        manager?.fetchItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //hide that nav bar
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailViewController, let item = sender as? Item {
                //make sure we send the correct item to the detail view controller
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
        //we just got word our model has changed
        //we are somewhere in the background
        //go get the main thread
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.customRefreshView.stopAnimating()
        }
    }
    
    func userDidSelect(_ item: Item) {
        //the user has selected an item from the list
        //let's show the details about it
        performSegue(withIdentifier: "Detail", sender: item)
    }
}
