//
//  ListCell.swift
//  CatchTestSam
//
//  Created by smoriyasu on 26/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell
{
	var record : Record?;
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configure(record : Record)
	{
		self.record = record;
		self.textLabel?.text = record.title;
		self.detailTextLabel?.text = record.subtitle;
	}
}
