//
//  BaseViewModel.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import FruitKit

/// Inherit from this to have screen analytics reported performed
open class BaseViewModel {
    private let analyticsService: AnalyticsServiceProtocol?
    private let timer: Timer
    
    init(analyticsService: AnalyticsServiceProtocol?) {
        self.analyticsService = analyticsService
        timer = Timer.createStartedTimer()
    }
    
    func reportViewShown() {
        if timer.isRunning { //have not yet reported
            let timeTaken = timer.stop()
            analyticsService?.reportScreenShown(time: timeTaken)
        }
    }
}
