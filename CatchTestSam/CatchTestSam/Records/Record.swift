//
//  Record.swift
//  CatchTestSam
//
//  Created by smoriyasu on 26/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit
import SwiftyJSON

class Record: NSObject
{
	var id : Int = -1;
	var title : String = "";
	var subtitle: String = "";
	var content: String = "";
	
	init(json : JSON)
	{
		id = json["id"].intValue;
		title = json["title"].stringValue;
		subtitle = json["subtitle"].stringValue;
		content = json["content"].stringValue;
	}
}
