//
//  FruitService.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public class FruitService: BaseService, FruitServiceProtocol {
    public func getFruits(completion: @escaping FruitCompletion) {
        get(path: "data.json", completion: completion)
    }
}
