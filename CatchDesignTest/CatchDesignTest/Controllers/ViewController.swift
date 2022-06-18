//
//  ViewController.swift
//  CatchDesignTest
//
//  Created by Shafee Rehman on 18/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData : [Model] = []
    
    let imgView : UIImageView = UIImageView(image: UIImage(named: Constants.loaderImageName))
    var logo: UIImageView = UIImageView(image: UIImage(named: Constants.logoImageName))
    
    let refreshControl = UIRefreshControl()
    var refreshView : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setting up table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        //registering Cell
        tableView.register(UINib(nibName: Constants.TableViewCellName, bundle: nil), forCellReuseIdentifier: Constants.reuseableCell)
        
        //setting up our custom delegate to pass data fetched from API
        ApiManager.instance.delegate = self
        
        setupRefreshControl()
        setUpInitialRefreshView()
        
    }
}

//MARK: - Table View Delegate Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseableCell, for: indexPath) as! TableViewCell
        
        cell.title.text = tableData[indexPath.row].title
        cell.subTitle.text = tableData[indexPath.row].subtitle
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constants.detailViewIdentifier, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailViewIdentifier{
            
            if let indexPath = tableView.indexPathForSelectedRow{
                 let selectedRow = indexPath.row
                 let detailVC = (segue.destination as? DetailViewController)
                 detailVC?.content = self.tableData[selectedRow].content
                 detailVC?.modelTitle = self.tableData[selectedRow].title
             }
        }
    }
}

//MARK: - Custom API Delegate Methods

extension ViewController: ApiManagerDelegate {
    
    func didFetchData(fetchedData: [Model]) {
        
        tableData.removeAll()
        tableData = fetchedData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - Refresh control Setup and Initial Refresh View

extension ViewController {
    
    @objc func handleRefresh() {
        print("Starts refreshing")
        ApiManager.instance.fetch()
        startRefreshControl()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tableView.reloadData()
            self.stopRefreshControl()
            self.refreshView?.removeFromSuperview()
        }
    }
    
    func setupRefreshControl() {
        imgView.isHidden = true
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        imgView.frame = CGRect(x: (self.view.frame.width / 2) - 25, y: 10, width: 50, height: 50)
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = UIColor(named: Constants.Color.backColorName)
        refreshControl.addSubview(imgView)
    }
    
    func startRefreshControl() {
        imgView.isHidden = false
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = CGFloat(Double.pi * 2)
        rotation.isRemovedOnCompletion = false
        rotation.duration = 1
        rotation.repeatCount = Float.infinity
        imgView.layer.add(rotation, forKey: nil)
    }
    
    func stopRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.imgView.layer.removeAllAnimations()
            self.imgView.isHidden = true
            self.refreshControl.endRefreshing()
        }
    }
    
    func setUpInitialRefreshView(){
        
        navigationController?.isNavigationBarHidden = true
        
        refreshView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        refreshView?.backgroundColor = UIColor(named: Constants.Color.mainColorName)
        refreshView?.addSubview(logo)
        logo.frame = CGRect(x: ((refreshView?.frame.width)! / 2) - 66, y: ((refreshView?.frame.height)! / 2) - 60, width: 132, height: 60)
        
        tableView.addSubview(refreshView!)
    }

}
