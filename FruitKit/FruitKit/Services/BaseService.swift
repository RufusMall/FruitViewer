//
//  BaseService.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public class BaseService {
    private let webClient: WebClientProtocol
    internal let baseURL: URL
    private let decoder = JSONDecoder()
    
    /// init services
    /// - Parameters:
    ///   - webClient: defaults to using system shared Web Client
    ///   - baseURL: base URL
    public init(webClient: WebClientProtocol = WebClient.shared, baseURL: URL) {
        self.webClient = webClient
        self.baseURL = baseURL
    }
    
    public func get<T: Decodable>(path: String, completion: @escaping (Result<T, Error>)->()) {
        let url = self.baseURL.appendingPathComponent(path)
        get(url: url, completion: completion)
    }
    
    public func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>)->()) {
           webClient.get(url: url) { result in
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
