//
//  URLSessionProtocolTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class URLSessionProtocolTests: XCTestCase {
    
    // Test to ensure dataTask method is called with the provided URL
    func testDataTaskWithURL() {
        // Given
        let url = URL(string: "https://example.com")!
        let session = MockURLSession()
        
        // When
        _ = session.dataTask(with: url) { _, _, _ in }
        
        // Then
        XCTAssertEqual(session.url, url, "dataTask method was not called with the provided URL")
    }
}

class MockURLSession: URLSessionProtocol {
    var url: URL?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        let task = URLSession.shared.dataTask(with: URLRequest(url: url))
        return task
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}

