//
//  Result.swift
//  Catch
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}
