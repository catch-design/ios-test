//
//  ItemCellManager.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 03/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import Foundation

protocol ItemCell {
    var title: String { get }
    var subtitle: String { get }
}

/**
 Provides storage for the cell. In real world scenario the majority of the I/O and state of the cell will be going through here
 */
struct ItemCellManager: ItemCell {
    let title: String
    let subtitle: String
    
    init(item: Item) {
        self.title = item.title
        self.subtitle = item.subtitle
    }
}
