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

class FruitDetailsViewModel: BaseViewModel {
    private let fruit: Fruit
    weak var viewDelegate: FruitDetailsViewDelegate?
    
    //out
    var name: String = ""
    var price: String = ""
    var weight: String = ""
    
    init(fruit: Fruit, weightFormatter: WeightFormatter, currencyFormatter: CurrencyFormatter, analyticsService: AnalyticsServiceProtocol? = nil) {
        self.fruit = fruit
        
        let formattedCurrency = currencyFormatter.format(pence: fruit.price)
        let weightAsMeasurement = Measurement(value: Double(fruit.weight), unit: UnitMass.grams)
        let formattedWeight = weightFormatter.formatWeight(measurement: weightAsMeasurement)
        
        name = fruit.type
        price = "Price: \(formattedCurrency)"
        weight = "Weight: \(formattedWeight)"
        super.init(analyticsService: analyticsService)
    }
    
    func start() {
        viewDelegate?.didUpdate(viewModel: self)
        super.reportViewShown()
    }
}
