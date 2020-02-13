//
//  PriceFormatter.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

class CurrencyFormatter {
    private let formatter = NumberFormatter()

    func format(pence: Int) -> String {
        let inPounds = Double(pence) / Double(100)
        formatter.locale = Locale(identifier: "en_GB")
        formatter.numberStyle = .currency
        if let formatedCurrency = formatter.string(from: NSNumber(value: inPounds)) {
           return formatedCurrency
        }
        return ""
    }
}
