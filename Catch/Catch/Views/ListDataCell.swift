//
//  ListDataCell.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import UIKit

class ListDataCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(listData: ListItem) {
        
        titleLabel.text = listData.title.capitalized
        subtitleLabel.text = listData.subtitle.capitalized
    }


}
