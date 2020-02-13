//
//  AnalyticsService.swift
//  FruitKit
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

public protocol AnalyticsServiceProtocol {
    func reportNetworkEvent(time: TimeInterval)
}

public class AnalyticsService: AnalyticsServiceProtocol {
    let webClient: WebClient
    let baseURL: URL
    
    public init(baseURL: URL, webClient: WebClient = WebClient.shared) {
        self.baseURL = baseURL
        self.webClient = webClient
    }
    
    func performRequestForEvent(event: Event) {
        let url = event.createURL(baseURL: baseURL)
        webClient.get(url: url, completion: {_ in})
    }
    
    public func reportNetworkEvent(time: TimeInterval) {
        let event = Event.networkRequest(time: time)
        performRequestForEvent(event: event)
    }
}
