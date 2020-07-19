//
//  ItemsListPresenterTests.swift
//  CatchDesignTests
//
//  Created by Viajeros Lado B on 19/07/2020.
//  Copyright © 2020 ArielBurgos. All rights reserved.
//

import XCTest
import CoreData
@testable import CatchDesign

class ItemsListPresenterTests: XCTestCase {
    private var itemsListPresenter: ItemsListPresenter!
    private var itemsListView: ItemsListViewMock!
    private var itemsService: ItemsServiceProtocol!
    
    func testShowNewUsers() {
        givenAItemsListView()
        givenASuccessfullService()
        givenAItemsListPresenter()
        
        whenPresenterPrefetchItems()
        
        thenAnReloadTableIsDisplayed()
        thenAnLoadingIsDismissed()
    }
    
    func testShowInvalidNewUsers() {
        givenAItemsListView()
        givenAUnsuccessfullService()
        givenAItemsListPresenter()
        
        whenPresenterPrefetchItems()
        
        thenAnLoadingIsDismissed()
        thenAnMessageIsDisplayed()
    }
    
    private func givenAItemsListView() {
        itemsListView = ItemsListViewMock()
    }
    
    private func givenASuccessfullService() {
        itemsService = SuccessfullUserServiceMock()
    }
    
    private func givenAUnsuccessfullService() {
        itemsService = UnsuccessfullUserServiceMock()
    }
    
    private func givenAItemsListPresenter() {
        itemsListPresenter = ItemsListPresenter(itemsService: itemsService)
        itemsListPresenter.attachView(view: itemsListView)
    }
    
    private func whenPresenterPrefetchItems() {
        itemsListPresenter.fetchItems()
    }
    
    private func thenAnMessageIsDisplayed() {
        XCTAssertTrue(itemsListView.showMessageHasBeenCalled)
    }
    
    private func thenAnReloadTableIsDisplayed() {
        XCTAssertTrue(itemsListView.reloadTableHasBeenCalled)
    }
    
    private func thenAnLoadingIsDismissed() {
        XCTAssertTrue(itemsListView.hideLoadingBeenCalled)
    }
}

class SuccessfullUserServiceMock: NSObject, ItemsServiceProtocol {
    func fetchData(completion: @escaping ([Item]?, String) -> ()) {
        completion([],"Success")
    }
}

class UnsuccessfullUserServiceMock: NSObject, ItemsServiceProtocol {
    func fetchData(completion: @escaping ([Item]?, String) -> ()) {
        completion(nil, "Error")
        
    }
}

class ItemsListViewMock: NSObject, ItemsListViewProtocol {
    private(set) var reloadTableHasBeenCalled: Bool = false
    private(set) var showMessageHasBeenCalled: Bool = false
    private(set) var hideLoadingBeenCalled: Bool = false
    
    func reloadTable() {
        reloadTableHasBeenCalled = true
    }
    
    func showMessage(message: String) {
        showMessageHasBeenCalled = true
    }
    
    func hideLoading() {
        hideLoadingBeenCalled = true
    }
}
