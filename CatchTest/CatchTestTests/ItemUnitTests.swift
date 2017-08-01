//
//  ItemUnitTests.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import XCTest
@testable import CatchTest

class ItemUnitTests: XCTestCase {
    
    var goodJSON: [JSONDictionary]?
    var badJSON: [JSONDictionary]?
    
    override func setUp() {
        super.setUp()
        goodJSON = fileToJSON("goodJSON")
        badJSON = fileToJSON("badJSON")
    }
    
    func testMapping() {
        if let good = goodJSON {
            good.forEach({ (object) in
                if let item = Item(dictionary: object) {
                    XCTAssertNotNil(item)
                    XCTAssertEqual(1, item.id)
                    XCTAssertEqual("nonummy integer", item.title)
                    XCTAssertEqual("sapien arcu", item.subtitle)
                    XCTAssertEqual("Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.", item.content)
                }
            })
        }
        
        if let bad = badJSON {
            bad.forEach({ (object) in
                let item = Item(dictionary: object)
                XCTAssertNil(item)
            })
        }
    }

    
}
