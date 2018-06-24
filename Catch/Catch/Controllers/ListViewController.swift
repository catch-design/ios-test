//
//  ViewController.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import UIKit

/// Main ViewController: Load data to tableview when pull to refresh
class ListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    var listItems: [ListItem] = []
    
    // Properties for custom refresh controller
    var refreshView: UIView!
    var refreshImageIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .lightGray
        
        setupRefreshControl()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showAlert(with message: String) {
        let alert = Alert.showAlert(ofType: .failure, message: message, handler: { _ in
            self.refreshControl.endRefreshing()
        })
        present(alert, animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listItems.count > 0 {
            tableView.separatorStyle = .singleLine
            return listItems.count
        } else {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "catchLogo"))
            imageView.contentMode = .center
            tableView.backgroundView = imageView
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDataCell") as! ListDataCell
        cell.setCell(listData: listItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: listItems[indexPath.row].content)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .lightGray
        cell.alpha = 0.9
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetails":
            let destVC = segue.destination as! DetailViewController
            destVC.content = sender as? String
        default:
            print("")
        }
    }
    
    @objc func handleRefresh() {
        startRefreshControl()
        
        ApiManager.loadData(from: .listAll, decodingType: ListItem.self) { response in
            switch response {
            case .success(let results):
                
                self.listItems = results
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.stopRefreshControl()
                
            case .failure(let error):
                
                self.refreshControl.endRefreshing()
                if let error = error {
                    self.showAlert(with: error.localizedDescription)
                } else {
                    self.showAlert(with: "Something went wrong!")
                }
            }
        }
    }
}

extension ListViewController {
    //Custom Pull to refresher
    func setupRefreshControl() {
        let refreshContents = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)
        refreshView = refreshContents![0] as! UIView
        refreshView.frame = refreshControl.bounds
        refreshView.backgroundColor = .clear
        refreshImageIcon = refreshView.viewWithTag(1) as! UIImageView
        refreshControl.addSubview(refreshView!)
    }
    
    func startRefreshControl() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount = Float.infinity
        refreshImageIcon?.layer.add(rotateAnimation, forKey: nil)
        refreshImageIcon.isHidden = false
    }
    
    func stopRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshImageIcon.layer.removeAllAnimations()
            self.refreshImageIcon.isHidden = true
        }
    }
}
