//
//  BaseServiceTests.swift
//  FruitKitTests
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import XCTest
import FruitKit

class BaseServiceTests: XCTestCase {
    
    var webClient: WebClient!
    let workingURL = URL(string: "https://google.com")!
    let failingURL = URL(string: "https://asdasd.adsa.sdasd")!
    
    override func setUp() {
        webClient = WebClient(session: URLSession(configuration: .ephemeral))
    }
    
    func testBaseServiceURLAppendedToBaseURL() {
        typealias DecodableCompletion = (Result<[DecodableStruct],Error>)->()
        
        let mockClient = MockWebClient()
        let baseService = BaseService(webClient: mockClient, baseURL: URL(string: "https://domain.com")!, analyticsService: nil)
        baseService.get(path: "path") { (result: Result<DecodableStruct,Error>) in
            
        }
        
        XCTAssertNotNil(mockClient.completeURL)
        XCTAssertEqual(mockClient.completeURL, URL(string: "https://domain.com/path")!)
    }
    
    private struct DecodableStruct: Codable {
        
    }
    
    private class MockWebClient: WebClientProtocol {
        var completeURL: URL? = nil
        
        func get(url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionTask {
            self.completeURL = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
