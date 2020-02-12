//
//  FruitCellViewModel.swift
//  FruitViewer
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import FruitKit

class FruitCellViewModel {
    let name: String
    
    init(fruit: Fruit) {
        self.name = fruit.type
    }
}
