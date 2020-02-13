//
//  ShowFruitCoordinator.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import FruitKit
import UIKit

protocol FruitListCoordinatorDelegate: class {
    func didSelect(fruit: Fruit)
}

class ShowFruitCoordinator {
    private let fruitService: FruitServiceProtocol
    private let navController: UINavigationController
    private let analyticsService: AnalyticsServiceProtocol
    
    init(navController: UINavigationController, fruitService: FruitServiceProtocol, analyticsService: AnalyticsService) {
        self.fruitService = fruitService
        self.navController = navController
        self.analyticsService = analyticsService
    }
    
    func start() {
        let fruitListViewModel = FruitListViewModel(fruitService: fruitService, analyticsService: analyticsService)
        let fruitListViewContoller = FruitListViewController(viewModel: fruitListViewModel)
        fruitListViewModel.viewDelegate = fruitListViewContoller
        fruitListViewModel.coordinatorDelegate = self
        navController.setViewControllers([fruitListViewContoller], animated: false)
    }
}

extension ShowFruitCoordinator: FruitListCoordinatorDelegate {
    func didSelect(fruit: Fruit) {
        
        let fruitDetailsVM = FruitDetailsViewModel(fruit: fruit,
                                                   weightFormatter: WeightFormatter(),
                                                   currencyFormatter: CurrencyFormatter(),
                                                   analyticsService: analyticsService)
        
        let fruitDetailsViewController = FruitDetailsViewController(fruitDetailsViewModel: fruitDetailsVM)
        fruitDetailsVM.viewDelegate = fruitDetailsViewController
        
        navController.pushViewController(fruitDetailsViewController, animated: true)
    }
}
