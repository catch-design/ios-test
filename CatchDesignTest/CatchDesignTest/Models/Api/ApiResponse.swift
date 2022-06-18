//
//  ApiResponse.swift
//  CatchDesignTest
//
//  Created by Shafee Rehman on 18/06/22.
//

import Foundation

struct ApiResponse : Decodable{
    let id : Int
    let title : String
    let subtitle : String
    let content : String
}


