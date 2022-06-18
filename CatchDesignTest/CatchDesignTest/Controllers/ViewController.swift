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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //setting up table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.TableViewCellName, bundle: nil), forCellReuseIdentifier: Constants.reuseableCell)
        
        //setting up our custom delegate to pass data fetched from API
        ApiManager.instance.delegate = self
        ApiManager.instance.fetch()
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
        
        tableData = fetchedData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

