//
//  ListInteractor.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

class ListInteractor: NSObject, ListInteractorInputInterface {
    var output: ListInteractorOutputInterface?
    let dataManager: ListDataManager
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchListData() {
        dataManager.fetchListData { (dataList) in
            self.output?.fetchedListData(dataList)
        }
    }
}
