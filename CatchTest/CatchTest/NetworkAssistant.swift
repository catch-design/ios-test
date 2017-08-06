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

/**
 This is the network go-to if you want something from the web
 */
class NetworkAssistant {
    //Needs to be accessible to all objects
    //possibly maintain state, etc.
    static let shared = NetworkAssistant()
    
    /**
     This is how we request the items from the server. The closure gives us back an array of items ready to be given to whever needs them
     
     - Parameters:
        - url: The url this request goes to
        - completion: The closure we are given once the request returns
     
     */
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
