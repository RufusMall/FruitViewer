//
//  Environment.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public enum Environment: String {
    case devFruit = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/"
    case devAnalytics = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/stats"
    
    public var url: URL {
        return URL(string: self.rawValue)!
    }
}
