//
//  WebClientTests.swift
//  FruitKitTests
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import XCTest
import FruitKit

class WebClientTests: XCTestCase {
    
   private var webClient: WebClient!
   private let workingURL = URL(string: "https://google.com")!
   private let failingURL = URL(string: "https://asdasd.adsa.sdasd")!
    
    override func setUp() {
        webClient = WebClient(session: URLSession(configuration: .ephemeral))
    }
    
    func testValidRequestDoesNotError() {
        let expectation = self.expectation()
        
        let sucessfulResult = self.waitForResultForWebRequest(url: workingURL, expectation: expectation)
        switch sucessfulResult {
        case .success(let data):
            XCTAssertNotEqual(data.count, 0)
        case .failure(_):
            XCTFail("Expected valid request")
        }
    }
    
    func testIncorrectURLFailsNetworkRequest() {
        let expectation = self.expectation()
        let sucessfulResult = self.waitForResultForWebRequest(url: failingURL, expectation: expectation)
        switch sucessfulResult {
        case .success(_):
             XCTFail("Expected faling")
        case .failure(let error):
            XCTAssert(true, "UnpectedError: \(error)")
        }
    }
    
    func testReceiveErrorIfRequestCanceled() {
        
        let expectation = self.expectation()
        
        let request = webClient.get(url: workingURL) { (result) in
            expectation.fulfill()
            switch result {
            case .success(_):
                 XCTFail("Expected valid request")
            case .failure(let error):
                XCTAssert(true, "UnpectedError: \(error)")
            }
        }
        request.cancel()
        wait(for: [expectation], timeout: 10.0)
    }
    
    func waitForResultForWebRequest(url:URL, expectation: XCTestExpectation) -> Result<Data,Error> {
        
        var resultToReturn: Result<Data, Error>? = nil
        
        webClient.get(url: url) { (result) in
            resultToReturn  = result
            expectation.fulfill()
        }
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 10.0)
        return resultToReturn!
    }
}
