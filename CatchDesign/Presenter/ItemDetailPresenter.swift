//
//  ItemDetailPresenter.swift
//  CatchDesign
//
//  Created by Viajeros Lado B on 18/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import Foundation

protocol ItemDetailViewDelegate: NSObjectProtocol {
    func showItem(title: String, content: String)
}

class ItemDetailPresenter {
    weak private var view : ItemDetailViewDelegate?
    var item: Item?
    
    func attachView(view: ItemDetailViewDelegate?) {
        self.view = view
    }
    
    func setItem(item: Item?) {
        self.item = item
    }
    
    func loadItem() {
        guard let item = item else {
            ErrorManager.trackExeption(name: "No item")
            return
        }
        view?.showItem(title: item.title, content: item.content)
    }
}
