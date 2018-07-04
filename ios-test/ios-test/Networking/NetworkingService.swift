//
//  NetworkingService.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct NetworkingService {

    static func getDataArray(_ completion: @escaping ([DataModel]) -> ()) -> Void {
        Alamofire.request(Router.getData)
            .validate(statusCode: 200..<300)
            .responseArray { (response: DataResponse<[DataModel]>) in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
