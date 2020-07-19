//
//  ItemsListPresenter.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 17/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import UIKit

protocol ItemsListViewProtocol: NSObjectProtocol {
    func reloadTable()
    func showMessage(message: String)
    func hideLoading()
}

class ItemsListPresenter {
    private let itemsService: ItemsServiceProtocol
    var items: [Item] = []
    
    weak private var view : ItemsListViewProtocol?
    
    init(itemsService: ItemsServiceProtocol){
        self.itemsService = itemsService
    }
    
    func attachView(view: ItemsListViewProtocol?){
        self.view = view
    }
    
    func fetchItems() {
        itemsService.fetchData {[weak self] (items, message) in
            self?.view?.hideLoading()
            
            guard let items = items else {
                self?.view?.showMessage(message: message)
                return
            }
            self?.items = items
            self?.view?.reloadTable()
        }
    }
}
