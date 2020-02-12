//
//  HeadlineViewModelTests.swift
//  FruitViewer
//
//  Created by Rufus on 06/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import XCTest
@testable import FruitKit
@testable import FruitViewer

class FruitListViewModelTests: XCTestCase, FruitListViewDelegate {
    var fruitService: MockFruitService!
    var viewModel: FruitListViewModel! // sut
    var viewModelUpdatedExpectation: XCTestExpectation?
    
    override func setUp() {
        fruitService = MockFruitService(baseURL: Environment.devFruit.url)
        viewModel = FruitListViewModel(FruitService: fruitService)
        viewModel.viewDelegate = self
    }
    
    override func tearDown() {
        viewModelUpdatedExpectation = nil
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.title, "Fruit")
        XCTAssertEqual(viewModel.numberOfRows(section: 0),0)
    }
    
    func testViewModelLoadItem() {
        viewModelUpdatedExpectation = expectation(description: "viewModelUpdatedExpectation")
        viewModel.start()
        wait(for: [viewModelUpdatedExpectation!], timeout: 20.0)
        
        XCTAssertEqual(viewModel.title, "Fruit")
        XCTAssertEqual(viewModel.numberOfRows(section: 0), 10)
        XCTAssertEqual(viewModel.numberOfRows(section: 1), 0)
        
        let firstCell = viewModel.cellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstCell.name, "fruit type 0")
    }
    
    func testfailedRefreshStillShowsOldResults() {
        viewModelUpdatedExpectation = expectation(description: "viewModelUpdated")
        viewModelUpdatedExpectation?.expectedFulfillmentCount = 2
        
        viewModel.start()
        fruitService.reloadIdentifier = "reloaded "
        fruitService.shouldFail = true
        viewModel.refresh()
        wait(for: [viewModelUpdatedExpectation!], timeout: 20.0)
        
        XCTAssertEqual(viewModel.title, "Fruit")
        XCTAssertEqual(viewModel.numberOfRows(section: 0), 10)
        XCTAssertEqual(viewModel.numberOfRows(section: 1), 0)
        
        let firstCell = viewModel.cellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstCell.name, "fruit type 0")
    }
    
    func testViewModelRefreshReloadsResults() {
        viewModelUpdatedExpectation = expectation(description: "viewModelUpdated")
        viewModelUpdatedExpectation?.expectedFulfillmentCount = 2
        
        viewModel.start()
        fruitService.reloadIdentifier = "reloaded "
        viewModel.refresh()
        wait(for: [viewModelUpdatedExpectation!], timeout: 20.0)
        
        XCTAssertEqual(viewModel.title, "Fruit")
        XCTAssertEqual(viewModel.numberOfRows(section: 0), 10)
        XCTAssertEqual(viewModel.numberOfRows(section: 1), 0)
        
        let firstCell = viewModel.cellViewModel(for: IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstCell.name, "reloaded fruit type 0")
    }
    
    func didUpdate(viewModel: FruitListViewModel) {
        viewModelUpdatedExpectation?.fulfill()
    }
}

class MockFruitService: BaseService, FruitServiceProtocol {
    
    var reloadIdentifier = ""
    var shouldFail = false
    
    func getFruits(completion: @escaping FruitService.FruitCompletion) {
        if shouldFail {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion(.failure(NSError(domain: "test", code: 2, userInfo: nil)))
            }
            return
        }
        var fruits = [Fruit]()
        let count = 10
        for i in 0..<count {
            let fruit = Fruit(type: "\(reloadIdentifier)fruit type \(i)", price: i, weight: i)
            fruits.append(fruit)
        }
        
        let fruitResponse = FruitResponse(fruit: fruits)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion(.success(fruitResponse))
        }
    }
}
