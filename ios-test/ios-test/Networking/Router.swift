//
//  Router.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import Alamofire

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
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        switch self {
        case .getData:
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            } catch {
                print("In catch")
            }
        }
        return urlRequest
    }
}

