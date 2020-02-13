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
    let fruitService: FruitServiceProtocol
    let navController: UINavigationController
    
    init(navController: UINavigationController, fruitService: FruitServiceProtocol) {
        self.fruitService = fruitService
        self.navController = navController
    }
    
    func start() {
        let fruitListViewModel = FruitListViewModel(FruitService: fruitService)
        let fruitListViewContoller = FruitListViewController(viewModel: fruitListViewModel)
        fruitListViewModel.viewDelegate = fruitListViewContoller
        fruitListViewModel.coordinatorDelegate = self
        navController.setViewControllers([fruitListViewContoller], animated: true)
    }
}

extension ShowFruitCoordinator: FruitListCoordinatorDelegate {
    func didSelect(fruit: Fruit) {
        print("DID SELECT, DIDSELECT")
    }
}
