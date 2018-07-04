//
//  ListViewController.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    
    private var data: [DataModel] = []
    private let tableViewYOffset: CGFloat = 20
    private let refreshControl = UIRefreshControl()
    private var customRefreshControl: CustomRefreshControl!

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
        tableView.dataSource = self
        tableView.delegate = self

        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(ListViewController.loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl

        customRefreshControl = CustomRefreshControl(frame: refreshControl.bounds)
        refreshControl.addSubview(customRefreshControl)
    }

    // MARK: - Networking

    @objc private func loadData() {
        customRefreshControl.beginRefreshing()
        
        NetworkingService.getDataArray { [weak self] data in
            self?.data = data
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()

            self?.refreshControl.endRefreshing()
            self?.customRefreshControl.endRefreshing()
        }
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.cellReuseIdentifier, for: indexPath) as! DataTableViewCell
        let dataModel = data[indexPath.row]
        cell.configure(with: dataModel)
        return cell
    }

    // Get DataModel at row and set on DetailViewController before pushing.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailViewController = DetailViewController()
        let dataModel = data[indexPath.row]
        detailViewController.dataModel = dataModel

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListViewController: UIScrollViewDelegate {

    // Scroll the Catch logo if pulling down, and transition the views background color.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = -scrollView.contentOffset.y
        if offset > tableViewYOffset {
            let progress = (offset - self.tableViewYOffset) / 100
            self.view.backgroundColor = UIColor.transitionColor(fromColor: .black, toColor: .darkGray, progress: progress)

            logoTopConstraint.constant = offset
            UIView.animate(withDuration: 0.1) {
                self.view.setNeedsLayout()
            }
        }
    }
    
}
