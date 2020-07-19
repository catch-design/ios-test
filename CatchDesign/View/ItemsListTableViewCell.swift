//
//  ItemsListTableViewCell.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 17/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class ItemsListTableViewCell: UITableViewCell {
    struct Constants {
        static let identifier = "ItemsListTableViewCell"
        static let height: CGFloat = 60
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
}
