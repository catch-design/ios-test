//
//  NetworkAssistant.swift
//  CatchTest
//
//  Created by Hristo Uzunov on 01/08/2017.
//  Copyright © 2017 HristoUzunov. All rights reserved.
//

import Foundation

typealias JSONArray = [Any]
typealias JSONDictionary = [String: Any]

let itemsURL = URL(string: "https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json")!

class NetworkAssistant {
    static let shared = NetworkAssistant()
    
    func fetchItems(from url: URL, completion: @escaping ([Item]?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if nil == error {
                if let validData = data, let jsonArray = try? JSONSerialization.jsonObject(with: validData, options: .allowFragments) as? JSONArray {
                    var tempItemsArray = [Item]()
                    jsonArray?.forEach({ (object) in
                        if let validJSONObject = object as? JSONDictionary, let item = Item(dictionary: validJSONObject)  {
                            tempItemsArray.append(item)
                        }
                    })
                    
                    completion(tempItemsArray)
                    return
                }
            }
            
            completion(nil)
        }
        
        task.resume()
    }
}
