//
//  ItemsServiceTests.swift
//  CatchDesignTests
//
//  Created by Viajeros Lado B on 19/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import XCTest
import CoreData
@testable import CatchDesign


class ItemsServiceTest: XCTestCase {
    private var itemsService: ItemsServices!
    
    func testFetchItems() {
        let fetchItemsExpectation = expectation(description: "Fetch Items OK")
        
        givenAItemsService()
        whenGetItems(expectation: fetchItemsExpectation)
        thenExpectationIsCalled(expectation: fetchItemsExpectation)
    }
    
    private func givenAItemsService() {
        itemsService = ItemsServices()
    }
    
    private func whenGetItems(expectation: XCTestExpectation) {
        itemsService.fetchData { (items, message) in
            if let _ = items {
                expectation.fulfill()
            }
        }
    }
    
    private func thenExpectationIsCalled(expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: 10)
    }
}
