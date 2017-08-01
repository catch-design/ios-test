//
//  ListInteractorIOInterface.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import Foundation

protocol ListInteractorInputInterface {
    func fetchListData()
}

protocol ListInteractorOutputInterface {
    func fetchedListData(_ datas: [DataEntity])
}
