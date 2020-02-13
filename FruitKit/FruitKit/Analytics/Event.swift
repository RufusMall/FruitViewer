//
//  Event.swift
//  FruitKit
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

internal enum Event {
    case networkRequest(time: TimeInterval)
    case display(time: TimeInterval)
    case report(error: String)
}

private extension TimeInterval {
    func toMS() -> Int{
        return Int(self * 1000)
    }
}

internal extension Event {
    var queryParams: [URLQueryItem] {
        switch self {
        case .networkRequest(let time):
            let timeMS = time.toMS()
            return [URLQueryItem(name: "event", value: "load"), URLQueryItem(name: "data", value: "\(timeMS)")]
        case .display(let time):
            let timeMS = time.toMS()
            return [URLQueryItem(name: "event", value: "display"), URLQueryItem(name: "data", value: "\(timeMS)")]
        case .report(let error):
            return [URLQueryItem(name: "event", value: "error"), URLQueryItem(name: "data", value: error)]
        }
    }
    
    func createURL(baseURL: URL) -> URL {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = self.queryParams
        let completeURL = urlComponents.url!
        return completeURL
    }
}
