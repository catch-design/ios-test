//
//  ItemsListView.swift
//  CatchDesignUITests
//
//  Created by Viajeros Lado B on 19/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import XCTest

struct ItemsListView {
    static let app = XCUIApplication()
    static let table = app.tables.firstMatch
    static let firstCell = table.cells.firstMatch
    static let firstCellTitle = firstCell.staticTexts["TitleLabel"]
    
    static func tapFirstCell() -> ItemDetailsView.Type {
        firstCell.tap()
        return ItemDetailsView.self
    }
    
    static func pullDownToRefresh() {
        let start = table.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.2))
        let finish = table.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0.7))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
