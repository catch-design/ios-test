//
//  UnitTests.swift
//  UnitTests
//
//  Created by Shafee Rehman on 18/06/22.
//

import XCTest

class UnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Testing if API URL does return correct Status :- 200
    func testValidApiCallGetsHTTPStatusCode200() throws {
        
      // given our api url
      let urlString = "https://raw.githubusercontent.com/catchnz/ios-test/master/data/data.json"
      let url = URL(string: urlString)!
      
      let promise = expectation(description: "Status code: 200")

        //URL implementation as same in PerformRequest Action
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if(error != nil){
                XCTFail("Error: \(error!.localizedDescription)")
                return
            }
            else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 200{
                    promise.fulfill()
                }
                else{
                    XCTFail("Status code: \(statusCode)")
                }
                
            }
            
        }
        task.resume()
        
        //due to asynchronous method
        wait(for: [promise], timeout: 5)
        
    }
    
    
    //Testing if Decoder class does decode JSON from Documentation
    func testCanParseJsonAndDecodes() throws {
    
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "jsonObjectForTest", ofType: "json") else { fatalError("json not found") }
        
        
        guard let JSON = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("unable to convert")
        }
     
        let jsonData = JSON.data(using: .utf8)!
        
        //Here we pass our decoder class
        let decodedData = try JSONDecoder().decode(ApiResponseForTesting.self, from: jsonData)
        
        //Testing All data that we will work with
        XCTAssertEqual("nonummy integer", decodedData.title)
        XCTAssertEqual(1, decodedData.id)
        XCTAssertEqual("sapien arcu", decodedData.subtitle)
        XCTAssertEqual("This is test content", decodedData.content)
       
        
    }

}
