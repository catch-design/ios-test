//
//  Theme.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import UIKit

enum Theme {

    static func applyTheming() {
        UINavigationBar.appearance().barTintColor = UIColor.navBarGrey
        UINavigationBar.appearance().isOpaque = true
    }

}
