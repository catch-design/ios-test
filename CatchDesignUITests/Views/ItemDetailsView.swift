//
//  ItemDetailsView.swift
//  CatchDesignUITests
//
//  Created by Viajeros Lado B on 19/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import XCTest

struct ItemDetailsView {
    static let app = XCUIApplication()
    static let backButton = app.navigationBars.firstMatch.buttons["Back"]
    static let scrollView = app.scrollViews
    static let contentLabel = scrollView.staticTexts["ContentLabel"]

    static func tapBackButton() -> ItemsListView.Type {
        backButton.tap()
        return ItemsListView.self
    }
}
