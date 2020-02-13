//
//  MockAnalyticsService.swift
//  FruitViewerTests
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import FruitKit

class MockAnalyticsService: AnalyticsServiceProtocol {
    var didReportScreen = false
    var didReportNetwork = false
    
    func reportNetwork(time: TimeInterval) {
        didReportNetwork = true
    }
    
    func reportScreenShown(time: TimeInterval) {
        didReportScreen = true
    }
}
