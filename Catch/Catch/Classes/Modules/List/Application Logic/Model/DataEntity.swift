//
//  DataEntity.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import ObjectMapper

class DataEntity: Mappable {
    var id: Int?
    var title: String?
    var subtitle: String?
    var content: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        content <- map["content"]
    }
}
