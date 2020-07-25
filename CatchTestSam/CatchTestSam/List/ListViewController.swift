//
//  ListViewController.swift
//  CatchTestSam
//
//  Created by smoriyasu on 25/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit
import Refreshable

class ListViewController: UITableViewController {

	let recordCollection = RecordCollection(fetchURL: URL(string: "https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json")!);
	let pullDownHeight : CGFloat = 111;
	let animator = SpinnerAnimator();
	
	
    var coverView : UIView!
    var logoView : UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		

		self.tableView.addPullToRefresh(withAnimator: animator, height: pullDownHeight, action: self.refresh)

		self.coverView = UIView();
		self.coverView.isUserInteractionEnabled = false;
		self.coverView.backgroundColor = .black;
		self.logoView = UIImageView(image: UIImage(named: "Logo"));
		self.coverView.addSubview(self.logoView);
		
		self.tableView.addSubview(self.coverView)
    }
	
	override func viewDidLayoutSubviews() {
		let safeAreaBounds = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: self.tableView.contentSize.height);
		self.coverView.frame = safeAreaBounds;
		
		let midPoint = (self.tableView.bounds.height - (self.tableView.safeAreaInsets.top + self.tableView.safeAreaInsets.bottom)) / 2;
		self.logoView.center = CGPoint(x: self.coverView.center.x, y: midPoint) ;
	}
	
	func refresh()
	{
		self.recordCollection.fetchRecords
		{
			self.tableView.reloadData();
			self.hideCover();
			self.tableView.stopPullToRefresh();
		}
    }
	
	
	func hideCover()
	{
		UIView.animate(withDuration: 0.3, animations:
		{
			self.coverView.alpha = 0.25;
		})
		{ (finished) in
			
		}
	}
	
	// MARK: Status Bar settings
	
	override var prefersStatusBarHidden: Bool {
		get {
			return false
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
    // MARK: - Table view delegate
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60;
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return recordCollection.records.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath);
		
		if let listCell = cell as? ListCell
		{
			let record = recordCollection.records[indexPath.row];
			listCell.configure(record: record);
		}
		
        return cell
    }
	
	// MARK: Scroll View Delegate
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		let fixedOffset = -(self.tableView.contentOffset.y + self.tableView.safeAreaInsets.top);
		let maxOffset = pullDownHeight - self.tableView.safeAreaInsets.top;
		animator.setColorFromDisplacement(offset: fixedOffset, maxOffset: maxOffset);
	}
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
		
		if let destination = segue.destination as? ContentViewController, let tappedCell = sender as? ListCell
		{
			destination.record = tappedCell.record;
		}
    }
    

}
