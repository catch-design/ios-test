//
//  ApiService.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import Foundation
import Alamofire

enum HttpError: Error {
    case invalidUrl
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl: return "Invalid URL."
        }
    }
}


protocol APIService {
    static func loadData<T: Codable>(from: Path, decodingType: T.Type, completion: @escaping (Result<[T]>) -> Void)
}

///  Generic Class to handle any http request with generic object mapping
///
/// - Parameters:
///   - from: Routing url path including endpoint.
///   - ecodingType: Generic Object to be mapped with jSON data.
/// - Returns: Results with mapped object(suscess) or with error(failure).
class ApiManager: APIService {
    static func loadData<T>(from: Path, decodingType: T.Type, completion: @escaping (Result<[T]>) -> Void) where T: Codable {
        let endpoint = from
        guard let url = endpoint.urlComponents.url else {
            completion(.failure(HttpError.invalidUrl))
            return
        }
   
        Alamofire.request(url,
                          method: .get,
                          encoding: URLEncoding.default)
            .validate(statusCode: 200..<300)
          
            .responseJSON { response in
                
                // Check the response
                guard response.result.isSuccess else {
                    print("Error while fetching data from the server: \(String(describing: response.result.error))")
                    completion(.failure(response.result.error))
                    return
                }
                // Check result has data in it
                guard let data = response.data else {
                    print("No data in the response: \(String(describing: response.result.error))")
                    completion(.failure(response.result.error))
                    return
                }
                let jsonParser = JSONParse()
                let parsedResults = jsonParser.parse(data: data, decodingType: T.self)
                completion(parsedResults)
        }
    }
}
