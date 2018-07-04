//
//  UIColor.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    /// Initialize with a hex Integer, and an optional alpha value.
    /// - parameter hex: 6 digit hex value
    /// - parameter alpha: Alpha value between 0.0 and 1.0.
    ///
    /// - returns: UIColor
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    static let midGrey = UIColor(hex: 0x979797)
    static let navBarGrey = UIColor(hex: 0xFAFAFA, alpha: 0.9)

}
