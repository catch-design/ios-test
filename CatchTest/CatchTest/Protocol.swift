//
//  Protocol.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 05/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import UIKit

protocol ViewLoading {
    static func loadFromNib<T: NibName>() -> T?
}

extension ViewLoading {
    static func loadFromNib<T: NibName>() -> T? {
        return Bundle.main.loadNibNamed(T.nibName, owner: self, options: nil)?.first as? T
    }
}

protocol NibName {
    static var nibName: String { get }
}

extension NibName {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UIView: ViewLoading, NibName {
    
}

protocol ReuseIdenifier {
    static var reuseIdentifier: String { get }
}
