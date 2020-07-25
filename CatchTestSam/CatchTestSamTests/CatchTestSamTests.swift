//
//  CatchTestSamTests.swift
//  CatchTestSamTests
//
//  Created by smoriyasu on 25/07/20.
//  Copyright © 2020 smoriyasu. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import CatchTestSam

class CatchTestSamTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsingSingleRecord() throws {
		let singleJson = JSON(parseJSON: """
		{
					"id": 1,
					"title": "nonummy integer",
					"subtitle": "sapien arcu",
					"content": "Donec diam neque, vestibulum eget, vulputate ut."
				}
		""");
		
		let record = Record(json: singleJson);
		
		XCTAssertEqual(record.id, 1);
		XCTAssertEqual(record.title, "nonummy integer");
		XCTAssertEqual(record.subtitle, "sapien arcu");
		XCTAssertEqual(record.content, "Donec diam neque, vestibulum eget, vulputate ut.");
    }
	
	func testParsingAllRecords() throws {
		if let path = Bundle.main.path(forResource: "data", ofType: "json") {
			do {
				let testData = try Data(contentsOf: URL(fileURLWithPath: path))
				let json = try JSON(data: testData);
				let recordCollection = RecordCollection(fetchURL: URL(string: "a.com")!);
				recordCollection.parseRecords(json: json)
				XCTAssertGreaterThan(recordCollection.records.count, 0);
			} catch {
				debugPrint("local json test data missing")
				XCTAssert(false);
			}
		}
	}
	
	func testDownloadingData() throws {
		let expectation = XCTestExpectation(description: "Download json data")
		
		
		let recordCollection = RecordCollection(fetchURL: URL(string: "https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json")!);
		recordCollection.fetchRecords {
			XCTAssertGreaterThan(recordCollection.records.count, 0);
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 10.0)
	}
}
