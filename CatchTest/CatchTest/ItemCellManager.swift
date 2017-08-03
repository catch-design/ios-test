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

struct ItemCellManager: ItemCell {
    var title: String
    var subtitle: String
    
    init(item: Item) {
        self.title = item.title
        self.subtitle = item.subtitle
    }
}
