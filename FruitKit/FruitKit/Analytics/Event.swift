//
//  Event.swift
//  FruitKit
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

internal enum Event {
    case networkRequest(time: TimeInterval)
}

internal extension Event {
    
    var queryParams: [URLQueryItem] {
        switch self {
        case .networkRequest(let time):
            let time = Int(time * 1000)
            return [URLQueryItem(name: "event", value: "load"), URLQueryItem(name: "data", value: "\(time)")]
        }
    }
    
    func createURL(baseURL: URL) -> URL {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = self.queryParams
        let completeURL = urlComponents.url!
        return completeURL
    }
}
