//
//  EndPoints.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://raw.githubusercontent.com"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: baseURL)!
        components.path = path
        
        return components
    }
}

enum Path {
    case listAll
    case details
    // extend endpoints here
}

extension Path: Endpoint {
    var path: String {
        switch self {
        case .listAll: return "/catchnz/ios-test/master/data/data.json"
        case .details:return "/testEndpoint"
            //Extend end points like this
            
        }
        
    }
}
