//
//  ItemTableViewCell.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 03/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

let cellBackgroundColor = CGFloat(190.0/255.0)

class ItemTableViewCell: UITableViewCell, ReuseIdenifier {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var subtitleLabel: UILabel!
    
    var model: ItemCell? {
        didSet {
            titleLabel.text = model?.title
            subtitleLabel.text = model?.subtitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(white: cellBackgroundColor, alpha: 0.97)
        accessoryView = UIImageView(image: #imageLiteral(resourceName: "disclosure"))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            setSelected(false, animated: true)
        }
    }
    
    static var reuseIdentifier: String {
        return "ItemCell"
    }

}
