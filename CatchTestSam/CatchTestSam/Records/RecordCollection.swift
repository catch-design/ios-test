//
//  RecordCollection.swift
//  CatchTestSam
//
//  Created by smoriyasu on 26/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecordCollection: NSObject
{
	var fetchURL : URL;
	var records : [Record] = [];
	
	init(fetchURL : URL)
	{
		self.fetchURL = fetchURL;
	}
	
	func fetchRecords(completionHandler: @escaping() -> Void)
	{
		var request = URLRequest(url: fetchURL)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")

		let session = URLSession.shared
		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			print(response!)
			do {
				let json = try JSON(data: data!);
				self.parseRecords(json: json);
				//print(json)
			} catch {
				print("error")
			}
			DispatchQueue.main.async {
				completionHandler();
			}
		})

		task.resume()
	}
	
	func parseRecords(json : JSON)
	{
		self.records = [];
		if let array = json.array
		{
			for singleObject in array
			{
				let record = Record(json: singleObject);
				self.records.append(record);
			}
		}
	}
}
