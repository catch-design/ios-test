//
//  BackgroundView.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 18/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    struct Constants {
        fileprivate static let backgroundImageName = "CatchLogo"
        fileprivate static let widthRatio: CGFloat = 0.5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: frame.width * Constants.widthRatio).isActive = true
        
        let backgroundImage = UIImage(named: Constants.backgroundImageName)
        imageView.image = backgroundImage

        self.backgroundColor = UIColor.Black.tone1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
