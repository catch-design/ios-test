//
//  ios_testTests.swift
//  ios-testTests
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import ios_test

class DataModelTest: XCTestCase {

    private var dataModel: [DataModel]?

    override func setUp() {
        super.setUp()
        dataModel = loadDataModel()
    }

    // MARK: - Helper methods

    private func loadDataModel() -> [DataModel]? {
        guard let path = Bundle(for: type(of: self)).path(forResource: "data", ofType: "json"),
            let json = try? String(contentsOfFile: path, encoding: .utf8),
            let dataModelArray = Mapper<DataModel>().mapArray(JSONString: json) else {
                return nil
        }
        return dataModelArray
    }

    func testDataModelNotNil() {
        guard loadDataModel() != nil else {
            XCTFail("DataModel array is nil")
            return
        }
    }

    func testDataModelCount() {
        XCTAssertEqual(dataModel!.count, 150, "DataModel array count should equal 150")
    }

    // MARK: - Test properties

    func testDataModelProperties() {
        guard let data = dataModel?.first else {
            XCTFail("Can't find first DataModel instance")
            return
        }
        XCTAssertEqual(data.dataId, 1, "First DataModel instance in array, id should equal 1")
        XCTAssertEqual(data.title, "nonummy integer", "First DataModel instance in array, title should equal 'nonummy integer' ")
        XCTAssertEqual(data.subTitle, "sapien arcu", "First DataModel instance in array, subtitle should equal 'sapien arcu'")
        XCTAssertTrue(data.content!.starts(with: "Donec diam neque"),
                      "First DataModel instance in array, content should start with equal 'Donec diam neque'")
    }
    
}
