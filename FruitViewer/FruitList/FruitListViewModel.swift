//
//  FruitViewModel.swift
//  FruitViewer
//
//  Created by Rufus on 06/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import FruitKit

protocol FruitListViewDelegate: class {
    func didUpdate(viewModel: FruitListViewModel)
}

public final class FruitListViewModel {
    private let FruitService : FruitServiceProtocol
    private var cellViewModels = [FruitCellViewModel]()
    private var fruits = [Fruit]()
    let title = "Fruit"
    var errorMesage: String?
    var shouldShowError = false
    
    weak var viewDelegate: FruitListViewDelegate?
    
    init(FruitService: FruitServiceProtocol) {
        self.FruitService = FruitService
    }
    
    func start() {
        refresh()
    }
    
    func refresh() {
        FruitService.getFruits { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let fruitResponse):
                let fruits = fruitResponse.fruit
                self.fruits = fruits
                self.cellViewModels = fruits.map { FruitCellViewModel(fruit: $0) }
                self.shouldShowError = false
            case .failure(let error):
                self.errorMesage = error.localizedDescription
                self.shouldShowError = self.cellViewModels.count == 0
                print(error.localizedDescription)
            }
            self.viewDelegate?.didUpdate(viewModel: self)
        }
    }
    
    func FruitToCellViewModel(fruit: Fruit) -> FruitCellViewModel {
        return FruitCellViewModel(fruit: fruit)
    }
    
    func numberOfRows(section: Int) -> Int {
        if section == 0 {
            return cellViewModels.count
        }
        else {
            return 0
        }
    }
    
    func cellViewModel(for indexPath: IndexPath) -> FruitCellViewModel {
        return cellViewModels[indexPath.row]
    }
}
