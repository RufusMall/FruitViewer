//
//  Fruit.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public struct FruitResponse: Codable {
    public let fruit: [Fruit]

    public init(fruit: [Fruit]) {
        self.fruit = fruit
    }
}

public struct Fruit: Codable {
    public let type: String
    
    ///units are pence and kg
    public let price, weight: Int

    
    /// constructor
    /// - Parameters:
    ///   - type: name of the fruit
    ///   - price: price in pense
    ///   - weight: weight in KG
    public init(type: String, price: Int, weight: Int) {
        self.type = type
        self.price = price
        self.weight = weight
    }
}
