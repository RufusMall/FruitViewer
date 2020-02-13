//
//  WeightFormatterTests.swift
//  FruitViewerTests
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import XCTest
@testable import FruitViewer

class FormatterTests: XCTestCase {
    
    func testWeightFormatterOutputingInKG() {
        let formatter = WeightFormatter()
        let weightKGs = Measurement(value: 30, unit: UnitMass.kilograms)
        let output = formatter.formatWeight(measurement: weightKGs)
        XCTAssertEqual(output, "30 kg")
    }
    
    func testWeightFormatterAlwaysConvertsToKG() {
        let formatter = WeightFormatter()
        let weightKGs = Measurement(value: 30, unit: UnitMass.grams)
        let output = formatter.formatWeight(measurement: weightKGs)
        XCTAssertEqual(output, "0.03 kg")
    }
    
    func testCurrencyFormatterOutput1Pounds() {
        let formatter = CurrencyFormatter()
        let output = formatter.format(pence: 100)
        XCTAssertEqual(output, "£1.00")
    }
    
    func testCurrencyFormatterOutput10pence() {
        let formatter = CurrencyFormatter()
        let output = formatter.format(pence: 10)
        XCTAssertEqual(output, "£0.10")
    }
    
    func testCurrencyFormatterOutput1Pence() {
        let formatter = CurrencyFormatter()
        let output = formatter.format(pence: 1)
        XCTAssertEqual(output, "£0.01")
    }
    
    func testCurrencyFormatterOutputing99Pence() {
        let formatter = CurrencyFormatter()
        let output = formatter.format(pence: 99)
        XCTAssertEqual(output, "£0.99")
    }
}
