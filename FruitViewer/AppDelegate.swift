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
    var fruitCoordinator: ShowFruitCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let analyticsService = AnalyticsService(baseURL: Environment.devAnalytics.url)
        let fruitService = FruitService(baseURL: Environment.devFruit.url, analyticsService: analyticsService)
        fruitCoordinator = ShowFruitCoordinator(navController: navigationController, fruitService: fruitService)
        
        fruitCoordinator?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
