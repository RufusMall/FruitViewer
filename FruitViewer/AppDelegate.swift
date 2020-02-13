//
//  AppDelegate.swift
//  FruitViewer
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit
import FruitKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let fruitListViewModel = FruitListViewModel(FruitService: FruitService(baseURL: Environment.devFruit.url))
        let fruitListViewContoller = FruitListViewController(viewModel: fruitListViewModel)
        fruitListViewModel.viewDelegate = fruitListViewContoller
        
        let navigationController = UINavigationController(rootViewController: fruitListViewContoller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
