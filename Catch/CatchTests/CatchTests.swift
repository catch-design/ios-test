//
//  CatchTests.swift
//  CatchTests
//
//  Created by Nandika Johann Weerasuriya on 6/24/18.
//  Copyright © 2018 NandikaWeerasuriya. All rights reserved.
//


import Mockingjay
import Nimble
import Quick
import XCTest

@testable import Catch

class CatchTests: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("NetworkRequest") {
            context("Success") {
                it("Should return data as response & parse") {
                    var returnedListData: [ListItem]?
                    
                    // 1.
                    // let path = Bundle.main.path(forResource: "catch-test-list", ofType: "json")!
                    let path = Bundle(for: type(of: self))
                    // let filePath = path.url(forResource: "catch-test-list", withExtension: "json")
                    
                    do {
                        if let file = path.url(forResource: "catch-test-list", withExtension: "json") {
                            let data = try Data(contentsOf: file)
                            
                            self.stub(uri("https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json"), jsonData(data))
                            ApiManager.loadData(from: .listAll, decodingType: ListItem.self, completion: { response in
                                
                                switch response {
                                case .success(let results):
                                    returnedListData = results
                                case .failure:
                                    print("Error")
                                }
                            })
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    expect(returnedListData).toEventuallyNot(beNil())
                    
                    expect(returnedListData![0].id) == 1
                    expect(returnedListData![0].title) == "nonummy integer"
                    expect(returnedListData![0].subtitle) == "sapien arcu"
                    expect(returnedListData![0].content) == "Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede."
                }
            }
            
            context("Failure") {
                it("Should return an Error") {
                    var returnedError: Error?
                    
                    let error = NSError(domain: "Not Found Error", code: 404, userInfo: nil)
                    
                    self.stub(uri("https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json"), failure(error))
                    ApiManager.loadData(from: .listAll, decodingType: ListItem.self, completion: { response in
                        
                        switch response {
                        case .success:
                            print("success")
                        case .failure(let error):
                            
                            returnedError = error
                        }
                    })
                    expect(returnedError).toEventuallyNot(beNil())
                }
            }
        }
    }
}
