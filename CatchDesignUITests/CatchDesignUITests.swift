//
//  CatchDesignUITests.swift
//  CatchDesignUITests
//
//  Created by Viajeros Lado B on 17/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import XCTest

class CatchDesignUITests: XCTestCase {
    
    override func setUp() {
        
        continueAfterFailure = false
        
        let itemsListView = ItemsListView.self
        let _ = itemsListView.table.waitForExistence(timeout: 0)
        
    }
    
    override func tearDown() {
        
    }
    
    func testShowItemsView() {
        let app = XCUIApplication()
        app.launch()
        
        // GIVEN
        let itemsListView = ItemsListView.self
        
        // WHEN
        itemsListView.pullDownToRefresh()
        // THEN
        assert(itemsListView.firstCell.exists, "Table loaded")
        
        // WHEN
        let detailView = itemsListView.tapFirstCell()
        // THEN
        assert(detailView.contentLabel.exists, "Content displayed")
        
        // WHEN
        let _ = detailView.tapBackButton()
        // THEN
        assert(itemsListView.firstCell.exists, "Navigation back success")
    }
}
