//
//  HTTPConnector.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 17/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Alamofire

struct HTTPConnector {
    struct Constants {
        static let path = "https://raw.githubusercontent.com"
    }
    
    static func request(relativeURL: String, method: HTTPMethod, parameters: Parameters?  = nil, headers: HTTPHeaders? = nil) -> DataRequest {
        
        var extraHeaders: HTTPHeaders = [
            "Accept": "application/json"
        ]
        if let headers = headers {
            for header in headers {
                extraHeaders.add(header)
            }
        }
        let url = "\(Constants.path)\(relativeURL)"
        
        
        return AF.request(url, method: method, parameters: parameters, headers: extraHeaders)
    }
    
    
    
    
}

