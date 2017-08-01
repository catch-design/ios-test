//
//  CatchTests.swift
//  CatchTests
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import XCTest
@testable import Catch

class CatchTests: XCTestCase {
    var dataManager = ListDataManager()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchData() {
        let expect = expectation(description: "Fetch data from internet")
        
        dataManager.fetchListData { (dataList) in
            if dataList.count <= 0 {
                XCTFail("Expected fetch contacts from internet to succeed, but it failed.")
            }
            
            if self.isSorted(array: dataList, isAscending: true) {
                expect.fulfill()
            } else {
                XCTFail("Expected sort contacts Ascending to succeed, but it failed.")
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testCapitalFirstLetter() {
        
    }
    
    func isSorted(array: [DataEntity], isAscending: Bool) -> Bool {
        
        var index = 0
        var sorted = true
        while index < (array.count - 1) && sorted {
            let compareResult = isAscending ? (array[index+1].title! < array[index].title!) : (array[index].title! < array[index+1].title!)
            if compareResult {
                sorted = false
            }
            index += 1
        }
        
        return sorted
    }
}
