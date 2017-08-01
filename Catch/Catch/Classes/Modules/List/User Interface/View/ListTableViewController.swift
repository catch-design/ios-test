//
//  ListTableViewController.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, ListTableViewInterface {
    var eventHandler: ListModuleInterface?
    var dataProperty: [DataEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        self.setContentOffsetToSimulateSwipeDownRefresh()
        self.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setContentOffsetToSimulateSwipeDownRefresh() {
        self.tableView.setContentOffset(CGPoint.init(x: 0, y: -(self.refreshControl?.frame.height)!), animated: true)
    }
    
    func configView() {
        // setup refresh control
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.backgroundColor = UIColor.gray
        
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
        
        // setup tableview backgroundview
        let backgroundImg = UIImageView.init(image: UIImage(named: "catchLogo"))
        
        backgroundImg.contentMode = UIViewContentMode.center
        
        self.tableView.backgroundView = backgroundImg
    }
    
    func updateView() {
        self.refreshControl?.beginRefreshing()
        eventHandler?.updateView()
    }
    
    // MARK: - List Table view interface
    func showListData(_ dataList: [DataEntity]) {
        dataProperty = dataList
        
        self.reloadEntities()
    }
    
    func reloadEntities() {
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    func refreshData() {
        self.updateView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataProperty != nil else {
            return 0
        }
        
        return dataProperty!.count
    }

    static let cellIdentifier = "listCellIdentifier"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewController.cellIdentifier, for: indexPath) as! ListTableViewCell
        let data = dataProperty?[indexPath.row]
        
        cell.titleTextLabel?.text = data?.title?.capitalizingFirstLetter()
        cell.subtitleTextLabel?.text = data?.subtitle?.capitalizingFirstLetter()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = dataProperty?[indexPath.row]
        self.eventHandler?.toDetail(data!, from: self)
    }
}
