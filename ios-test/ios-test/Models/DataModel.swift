//
//  DataModel.swift
//  ios-test
//
//  Created by Dean Woodward on 4/07/18.
//  Copyright © 2018 Dean Woodward. All rights reserved.
//

import Foundation
import ObjectMapper

struct DataModel: Mappable {
    var dataId: Int?
    var title: String?
    var subTitle: String?
    var content: String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        dataId <- map["id"]
        title <- map["title"]
        subTitle <- map["subtitle"]
        content <- map["content"]
    }
}
