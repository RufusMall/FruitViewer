//
//  FruitDetailsViewModel.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import FruitKit

protocol FruitDetailsViewDelegate: class {
    func didUpdate(viewModel: FruitDetailsViewModel)
}

class FruitDetailsViewModel {
    private let fruit: Fruit
    weak var viewDelegate: FruitDetailsViewDelegate?
    
    //out
    var name: String = ""
    var price: String = ""
    var weight: String = ""
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    func start() {
        name = fruit.type
        price = "\(fruit.price)"
        weight = "\(fruit.weight)"
        
        viewDelegate?.didUpdate(viewModel: self)
    }
}
