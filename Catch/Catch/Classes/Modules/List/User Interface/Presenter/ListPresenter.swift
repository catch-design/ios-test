//
//  ListPresenter.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

class ListPresenter: NSObject, ListInteractorOutputInterface, ListModuleInterface {
    var listInteractor: ListInteractorInputInterface?
    var listWireframe : ListWireframe?
    var listInterface: ListTableViewInterface?
    
    func updateView() {
        listInteractor?.fetchListData()
    }
    
    func fetchedListData(_ datas: [DataEntity]) {
        listInterface?.showListData(datas)
    }
    
    func toDetail(_ dataEntity: DataEntity, from sender: UIViewController) {
        listWireframe?.showDetailViewController(dataEntity, from: sender)
    }
}
