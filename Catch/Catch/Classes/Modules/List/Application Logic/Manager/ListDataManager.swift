//
//  ListDataManager.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

let URL_DATA = "https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json"

class ListDataManager: NSObject {
    func fetchListData(complete:(([DataEntity]) -> Void)!) {
        Alamofire.request(URL_DATA)
            .responseArray {
                (response: DataResponse<[DataEntity]>) in
                guard response.result.isSuccess else {
                    complete([])
                    return
                }
                
                self.sortDataList(response.result.value!, isAscending: true, complete: { (contacts) in
                    complete(contacts)
                })
        }
    }
    
    func sortDataList(_ dataList: [DataEntity], isAscending: Bool, complete:(([DataEntity]) -> Void)!) {
        let sortedContacts = dataList.sorted(by: { (data1, data2) -> Bool in
            return isAscending ? (data1.title! < data2.title!) : (data2.title! < data1.title!)
        })
        
        complete(sortedContacts)
    }
}
