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
    private let analyticsService: AnalyticsServiceProtocol
    private let window: UIWindow
    private let splitViewController: UISplitViewController
    
    init(window: UIWindow, fruitService: FruitServiceProtocol, analyticsService: AnalyticsService) {
        self.fruitService = fruitService
        self.window = window
        self.analyticsService = analyticsService
        self.splitViewController = UISplitViewController()
    }
    
    func start() {
        let fruitListViewModel = FruitListViewModel(fruitService: fruitService, analyticsService: analyticsService)
        let fruitListViewContoller = FruitListViewController(viewModel: fruitListViewModel)
        fruitListViewModel.viewDelegate = fruitListViewContoller
        fruitListViewModel.coordinatorDelegate = self
        
        let navController = UINavigationController(rootViewController: fruitListViewContoller)
        splitViewController.viewControllers = [navController]
        
        splitViewController.preferredDisplayMode = .allVisible
        window.rootViewController = splitViewController
        window.makeKeyAndVisible()
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
        splitViewController.showDetailViewController(fruitDetailsViewController, sender: self)
    }
}
