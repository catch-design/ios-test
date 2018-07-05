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

    static func getDataArray(_ completion: @escaping (DataResponse<[DataModel]>) -> ()) -> Void {
        Alamofire.request(Router.getData)
            .validate()
            .responseArray { (response: DataResponse<[DataModel]>) in
                completion(response)
            }
    }
}
