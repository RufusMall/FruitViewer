//
//  FruitDetailsViewModelTests.swift
//  FruitViewerTests
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import XCTest
@testable import FruitKit
@testable import FruitViewer

class FruitDetailsViewModelTests: XCTestCase, FruitDetailsViewDelegate {
    var viewModel: FruitDetailsViewModel! // sut
    var viewModelUpdatedExpectation: XCTestExpectation?
    
    override func setUp() {
        viewModel = FruitDetailsViewModel(fruit: Fruit(type: "apple", price: 200, weight: 4), weightFormatter: WeightFormatter(), currencyFormatter: CurrencyFormatter())
        
        viewModel.viewDelegate = self
    }
    
    override func tearDown() {
        viewModelUpdatedExpectation = nil
    }
    
    func testViewModelTestLoadFruit() {
        viewModelUpdatedExpectation = expectation(description: "viewModelUpdatedExpectation")
        viewModel.start()
        
        wait(for: [viewModelUpdatedExpectation!], timeout: 20.0)
        
        XCTAssertEqual(viewModel.name, "apple")
        XCTAssertEqual(viewModel.price, "Price: £2.00")
        XCTAssertEqual(viewModel.weight, "Weight: 0.004 kg")
    }
    
    func didUpdate(viewModel: FruitDetailsViewModel) {
        viewModelUpdatedExpectation?.fulfill()
    }
}
