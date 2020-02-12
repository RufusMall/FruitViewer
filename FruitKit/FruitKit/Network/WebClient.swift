//
//  WebClient.swift
//  FruitKit
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation

public class WebClient: WebClientProtocol {
    enum WebClientError: String, LocalizedError {
        case webResponseCodeError = "Server returned an unexpected result. Please try again."
        
        public var errorDescription: String? {
            return self.rawValue
        }
    }
    
    public static var shared: WebClient = WebClient(session: URLSession(configuration: .ephemeral))
    
    let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    @discardableResult
    open func get(url: URL, completion: @escaping (Result<Data,Error>)->()) -> URLSessionTask {
//        print(url)
        let task = session.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(WebClientError.webResponseCodeError))
                    return
                }
                
                if let data = data {
                    completion(.success(data))
                    return
                }
                fatalError("unexpected code path")
            }
        }
        task.resume()
        return task
    }
}
