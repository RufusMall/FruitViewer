//
//  BaseService.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public class BaseService {
    internal let baseURL: URL
    private let webClient: WebClientProtocol
    private let analyticsService: AnalyticsServiceProtocol?
    private let decoder = JSONDecoder()
    
    /// init services
    /// - Parameters:
    ///   - webClient: defaults to using system shared Web Client
    ///   - baseURL: base URL
    public init(webClient: WebClientProtocol = WebClient.shared, baseURL: URL, analyticsService: AnalyticsServiceProtocol?) {
        self.webClient = webClient
        self.baseURL = baseURL
        self.analyticsService = analyticsService
    }
    
    public func get<T: Decodable>(path: String, completion: @escaping (Result<T, Error>)->()) {
        let url = self.baseURL.appendingPathComponent(path)
        get(url: url, completion: completion)
    }
    
    public func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>)->()) {
        let timer = Timer.createStartedTimer()
        
        webClient.get(url: url) { result in
            let time = timer.stop()
            self.analyticsService?.reportNetworkEvent(time: time)
            
            switch result {
            case .success(let data):
                do {
                    let decodedItem = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedItem))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
