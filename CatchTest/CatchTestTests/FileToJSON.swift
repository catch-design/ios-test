//
//  FileToJSON.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import XCTest
@testable import CatchTest

extension XCTestCase {
    func fileToJSON(_ fileName: String) -> [JSONDictionary]? {
        if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                if let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [JSONDictionary] {
                    return jsonArray
                }
            }
        }
        
        return nil
    }
}
