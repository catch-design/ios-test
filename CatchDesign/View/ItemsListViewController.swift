//
//  ItemsListViewController.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 17/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class ItemsListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    
    private let presenter = ItemsListPresenter(itemsService: ItemsServices())
    
    var refreshControl: UIRefreshControl = {
        let newRefreshControl = UIRefreshControl()
        newRefreshControl.backgroundColor = UIColor.clear
        newRefreshControl.tintColor = UIColor.clear
        newRefreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return newRefreshControl
    }()
    
    var customView: UIView!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        
        // MARK: Configure table
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        loadCustomRefreshContents()
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refreshControl.endRefreshing()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        let customBackground = BackgroundView(frame: backgroundView.bounds)
        customBackground.center = backgroundView.center
        backgroundView.addSubview(customBackground)
    }

    // MARK: Private methods
    private func loadCustomRefreshContents() {
        let refreshView = Bundle.main.loadNibNamed("RefreshView", owner: nil, options: nil)![0] as! RefreshView
        refreshView.frame = refreshControl.bounds
        self.refreshControl.addSubview(refreshView)
    }
    

    
    @objc private func refresh(_ sender: Any) {
        presenter.fetchItems()
    }
}

// MARK:- ItemsListViewProtocol
extension ItemsListViewController: ItemsListViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showMessage(message: String) {
        showAlert(message: message)
    }
        
    func hideLoading() {
        refreshControl.endRefreshing()
    }
}


// MARK:- UITableViewDelegate, UITableViewDataSource
extension ItemsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsListTableViewCell.Constants.identifier, for: indexPath) as! ItemsListTableViewCell
        
        cell.titleLabel.text = presenter.items[indexPath.row].title
        cell.subtitleLabel.text = presenter.items[indexPath.row].subtitle
        cell.backgroundColor = .clear
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemsListTableViewCell.Constants.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ErrorManager.dropBreadCrumb(breadCrumb: "did select row at \(indexPath.row)")

        let item = presenter.items[indexPath.row]
        let viewController = ItemDetailViewController.initViewController(item: item)
        
        navigationController?.show(viewController, sender: nil)
    }
}

