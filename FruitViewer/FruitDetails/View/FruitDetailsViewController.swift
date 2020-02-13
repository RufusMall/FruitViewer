//
//  FruitDetailsViewController.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

class FruitDetailsViewController: UIViewController, FruitDetailsViewDelegate {
    
    let fruitDetailsViewModel: FruitDetailsViewModel
    
    let vStackView: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = UIStackView.spacingUseSystem
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    init(fruitDetailsViewModel: FruitDetailsViewModel) {
        self.fruitDetailsViewModel = fruitDetailsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(vStackView)
        vStackView.constrainPinningEdgesToSuperview(useSystemSpacing: true, multiplier: 1.0)
        vStackView.isLayoutMarginsRelativeArrangement = true
        
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(priceLabel)
        vStackView.addArrangedSubview(weightLabel)
        
        let lowerSpaceFillerView = UIView()
        vStackView.addArrangedSubview(lowerSpaceFillerView)
        
        fruitDetailsViewModel.start()
    }
    
    func didUpdate(viewModel: FruitDetailsViewModel) {
        titleLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        weightLabel.text = viewModel.weight
    }
}

import SwiftUI
import FruitKit

class FruitDetailsPreview: ViewControllerPreviewProvider<FruitDetailsViewController>, PreviewProvider {
    
    override class func makeController() -> UIViewController {
        
        let fruit = Fruit(type: "Apple", price: 200, weight: 100)
        let fruitDetailsVM = FruitDetailsViewModel(fruit: fruit, weightFormatter: WeightFormatter(), currencyFormatter: CurrencyFormatter())
        let fruitDetailsViewController = FruitDetailsViewController(fruitDetailsViewModel: fruitDetailsVM)
        fruitDetailsVM.viewDelegate = fruitDetailsViewController
        let navController = UINavigationController(rootViewController: fruitDetailsViewController)
        fruitDetailsVM.start()
        return navController
    }
}
