//
//  FruitServiceProtocol.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public protocol FruitServiceProtocol {
    typealias FruitCompletion = (Result<FruitResponse,Error>)->()
    
    /// get fruit
    /// - Parameter completion: the completion is guaranteed to be called on the main thread
    func getFruit(completion:@escaping FruitCompletion)
}
