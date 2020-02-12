//
//  FruitService.swift
//  FruitKitTests
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import XCTest
import FruitKit

class FruitServiceTests: FruitKitTestCase {
    
    private var fruitService: FruitServiceProtocol!
    
    override func setUp() {
        fruitService = FruitService(baseURL: self.testEnvironmentURL)
    }
    
    func testGetFruitSucceeds() {
        let expectation = self.expectation()
        
        fruitService.getFruit { (result) in
            switch result {
            case .success(let response):
                print(response)
                assert(response.fruit.count != 0)
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testEnsureCallbackOnMainThread() {
         let expectation = self.expectation()
        
        fruitService.getFruit { (result) in
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
}
