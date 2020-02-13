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
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let analyticsService = AnalyticsService(baseURL: Environment.devAnalytics.url)
        let fruitService = FruitService(baseURL: Environment.devFruit.url, analyticsService: analyticsService)
        fruitCoordinator = ShowFruitCoordinator(window: window, fruitService: fruitService, analyticsService: analyticsService)
        fruitCoordinator?.start()
        
        return true
    }
}
