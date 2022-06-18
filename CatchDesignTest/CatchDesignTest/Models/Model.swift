//
//  Model.swift
//  CatchDesignTest
//
//  Created by Shafee Rehman on 18/06/22.
//

import Foundation

class Model
{
    var id : Int
    var title : String
    var subtitle : String
    var content : String
    
    init(id: Int, title: String, subtitle: String, content: String){
        self.id = id
        self.title = title
        self.content = content
        self.subtitle = subtitle
    }
}
