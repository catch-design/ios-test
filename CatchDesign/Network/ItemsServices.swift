//
//  ItemsServices.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 17/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

protocol ItemsServiceProtocol {
    func fetchData(completion: @escaping (_ items: [Item]?, _ message: String) -> () )
}

struct ItemsServices: ItemsServiceProtocol {
    struct Constants {
        static let fetchItemURL = "/catchnz/ios-test/master/data/data.json"
    }
    
    func fetchData(completion: @escaping (_ items: [Item]?, _ message: String) -> () ) {
        HTTPConnector.request(relativeURL: Constants.fetchItemURL, method: .get).responseDecodable(of: [Item].self) {(result) in
            
            if let error = result.error {
                ErrorManager.trackExeption(error: error)
                completion(nil,  "Something is wrong, try later")
                return
            }
            
            completion(result.value, "success")
        }
    }
    
}

