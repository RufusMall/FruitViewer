//
//  NetworkProtocol.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public protocol WebClientProtocol {
    
    /// performs a simple get request to a remote resource
    /// - Parameters:
    ///   - url: complete url to resource
    ///   - completion: completion is executed on the main thread
    @discardableResult
    func get(url: URL, completion: @escaping (Result<Data,Error>)->()) -> URLSessionTask
}
