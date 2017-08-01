//
//  AppDependencies.swift
//  Catch
//
//  Created by XiankunCheng on 1/08/17.
//  Copyright © 2017 Xiankun Cheng. All rights reserved.
//

import UIKit

class AppDependencies {
    var listWireframe = ListWireframe()
    
    init() {
        self.configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        listWireframe.presentListInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        let listPresenter = ListPresenter()
        let listDataManager = ListDataManager()
        let listInteractor = ListInteractor(dataManager: listDataManager)
        
        listInteractor.output = listPresenter
        
        listPresenter.listInteractor = listInteractor
        listPresenter.listWireframe = listWireframe
        
        let detailWireframe = DetailWireframe()
        
        listWireframe.listPresenter = listPresenter
        listWireframe.detailWireframe = detailWireframe
    }
}
