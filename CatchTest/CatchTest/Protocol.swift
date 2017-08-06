//
//  Protocol.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 05/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

//I would be tempted to put a whole lot more here, i.e. horisontal communication, vertical communication, how we update model lists (because we are using value object, right), etc.

protocol NibName {
    static var nibName: String { get }
}

extension NibName {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: NibName {
    static func loadFromNib<T: NibName>() -> T? {
        return Bundle.main.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T
    }
}

protocol ReuseIdenifier {
    static var reuseIdentifier: String { get }
}
