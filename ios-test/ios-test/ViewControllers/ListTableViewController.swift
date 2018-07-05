//
//  ListTableViewController.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    private var data: [DataModel] = []

    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - View helpers

    private func configureView() {
        let nib = UINib(nibName: "DataTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DataTableViewCell.cellReuseIdentifier)

        // Remove trailing cell separators
        tableView.tableFooterView = UIView()

        tableView.rowHeight = 60
        tableView.separatorStyle = .none

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ListTableViewController.loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl

        let logoImageView = UIImageView(image: UIImage(named: "CatchLogo"))
        logoImageView.contentMode = .center
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(logoImageView)
        //tableView.sendSubview(toBack: tableView)
        //tableView.layer.insertSublayer(logoImageView.layer, at: 0)
        logoImageView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        //logoImageView.layer.insertSublayer(<#T##layer: CALayer##CALayer#>, below: <#T##CALayer?#>)
        //tableView.layer.insertSublayer(logoImageView.layer, at: 0)
    }

    // MARK: - Networking

    @objc private func loadData() {
//        NetworkingService.getDataArray { [weak self] data in
//            self?.data = data
//            self?.tableView.reloadData()
//            self?.tableView.refreshControl?.endRefreshing()
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.cellReuseIdentifier, for: indexPath) as! DataTableViewCell
        let dataModel = data[indexPath.row]
        cell.configure(with: dataModel)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Set data on detail view controller
        let detailViewController = DetailViewController()
        let dataModel = data[indexPath.row]
        detailViewController.dataModel = dataModel

        navigationController?.pushViewController(detailViewController, animated: true)
    }

}
