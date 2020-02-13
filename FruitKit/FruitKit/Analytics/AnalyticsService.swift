//
//  AnalyticsService.swift
//  FruitKit
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

public protocol AnalyticsServiceProtocol {
    func reportNetwork(time: TimeInterval)
    func reportScreenShown(time: TimeInterval)
    func reportError(error: String, lineNumber: Int, file: String)
}

//this is a trick so we can use the default paramaters in the protocol.
public extension AnalyticsServiceProtocol {
    func reportError(error: String, lineNumber: Int = #line, file: String = #file) {
        self.reportError(error: error, lineNumber: lineNumber, file: file)
    }
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
    
    public func reportNetwork(time: TimeInterval) {
        let event = Event.networkRequest(time: time)
        performRequestForEvent(event: event)
    }
    
    public func reportScreenShown(time: TimeInterval) {
        let event = Event.display(time: time)
        performRequestForEvent(event: event)
    }
    
    public func reportError(error: String, lineNumber: Int, file: String) {
        let report = "Error:\(error) atLine: \(lineNumber)  inFile:\(file)"
        performRequestForEvent(event: .report(error: report))
    }
}
