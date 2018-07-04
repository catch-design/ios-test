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

    // Handy color transition methods from:
    // https://stackoverflow.com/questions/15757872/manually-color-fading-from-one-uicolor-to-another
    // MARK: - UIColor+Percentage

    static func colorForProgress(progress:CGFloat) -> UIColor {
        var normalizedProgress = progress < 0 ?  0 : progress
        normalizedProgress = normalizedProgress > 1 ?  1 : normalizedProgress

        let R:CGFloat = 155.0 * normalizedProgress
        let G:CGFloat = 155.0 * (1 - normalizedProgress)
        let B:CGFloat = 0.0

        return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1)
    }

    static func transitionColor(fromColor:UIColor, toColor:UIColor, progress:CGFloat) -> UIColor {
        var percentage = progress < 0 ?  0 : progress
        percentage = percentage > 1 ?  1 : percentage

        var fRed:CGFloat = 0
        var fBlue:CGFloat = 0
        var fGreen:CGFloat = 0
        var fAlpha:CGFloat = 0

        var tRed:CGFloat = 0
        var tBlue:CGFloat = 0
        var tGreen:CGFloat = 0
        var tAlpha:CGFloat = 0

        fromColor.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        toColor.getRed(&tRed, green: &tGreen, blue: &tBlue, alpha: &tAlpha)

        let red:CGFloat = (percentage * (tRed - fRed)) + fRed;
        let green:CGFloat = (percentage * (tGreen - fGreen)) + fGreen;
        let blue:CGFloat = (percentage * (tBlue - fBlue)) + fBlue;
        let alpha:CGFloat = (percentage * (tAlpha - fAlpha)) + fAlpha;

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}

// MARK: -

extension UIColor {
    static let darkGray = UIColor(hex: 0x666666)
    static let midGrey = UIColor(hex: 0x979797)
    static let navBarGrey = UIColor(hex: 0xFAFAFA, alpha: 0.9)
}
