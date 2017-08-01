//
//  Item.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import Foundation

/**
  A map from network response to a Swift object
 */
struct Item {
    let id: Int
    let title: String
    let subtitle: String
    let content: String
    
    init?(dictionary: JSONDictionary) {
        let dictionaryKeysSet = Set(Array(dictionary.keys))
        if dictionaryKeysSet == Key.keys {
            //when we know that the dictionary we were given
            //is the dictionary we need
            //proceed with the mapping
            self.id = dictionary[Key.id] as? Int ?? 0
            self.title = dictionary[Key.title] as? String ?? ""
            self.subtitle = dictionary[Key.subtitle] as? String ?? ""
            self.content = dictionary[Key.content] as? String ?? ""
        }
        else {
            return nil
        }
    }
    
    ///A map to the keys we need
    private struct Key {
        static let id = "id"
        static let title = "title"
        static let subtitle = "subtitle"
        static let content = "content"
        
        static var keys: Set<String> {
            return Set([Key.id, Key.title, Key.subtitle, Key.content])
        }
    }
}
