//
//  CatchStringTests.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import XCTest
@testable import Catch

class CatchStringTests: XCTestCase {
    var strArray: [String] = []
    
    override func setUp() {
        super.setUp()
        
        for _ in 0 ..< 30 {
            strArray.append(self.randomString(length: Int(arc4random_uniform(100))).capitalizingFirstLetter())
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCapitalFirstLetter() {
        for str in strArray {
            XCTAssert(isCapitalFirstLetter(str))
        }
    }
    
    func isCapitalFirstLetter(_ str: String) -> Bool {
        let first = String(str.characters.prefix(1))
        
        if first.lowercased() != first {
            return true
        } else {
            return false
        }
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
