//
//  CatchUITests.swift
//  CatchUITests
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import XCTest

class CatchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMainUIFlow() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.tables.children(matching: .cell).matching(identifier: "tableViewCell").element(boundBy: 5).staticTexts["titleLabel"].tap()
        
        let contenttextviewTextView = app.textViews["contentTextView"]
        contenttextviewTextView.swipeUp()
        contenttextviewTextView.swipeDown()
        app.navigationBars.children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        
    }
    
}
