//
//  Router.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import Alamofire

// An extensible central Routing enum.
// Configure the HTTP methods and paths here.
// See: https://github.com/Alamofire/Alamofire/blob/master/Documentation/AdvancedUsage.md#routing-requests
enum Router: URLRequestConvertible {

    case getData

    var method: HTTPMethod {
        switch self {
        case .getData:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getData:
            return "data/data.json"
        }
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try NetworkingConstants.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("text/plain", forHTTPHeaderField: "Accept")

        switch self {
        case .getData:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        return urlRequest
    }
}

