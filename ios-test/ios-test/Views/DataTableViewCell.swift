//
//  DataTableViewCell.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    static let cellReuseIdentifier = "dataTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        // Add a custom selection view.
        let view = UIView()
        view.backgroundColor = UIColor.midGrey
        selectedBackgroundView = view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with data: DataModel) {
        titleLabel.text = data.title?.capitalized
        subtitleLabel.text = data.subTitle?.capitalized
    }
    
}
