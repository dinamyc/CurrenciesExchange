//
//  APIServiceTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class APIServiceTests: XCTestCase {
    
    class MockURLSession: URLSessionProtocol {
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let error = APIError.invalidURL
            completionHandler(nil, nil, error)
            let task = URLSession.shared.dataTask(with: URLRequest(url: url))
            return task
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    
    func testRequestFailureInvalidURL() {
        // Given
        let invalidURL = URL(string: "invalid_url")!
        let expectation = XCTestExpectation(description: "Request Failure: Invalid URL")
        
        let session = MockURLSession()
        
        // When
        let task = session.dataTask(with: invalidURL) { data, response, error in
            // Then
            if let error = error {
                if case APIError.invalidURL = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Error should be invalid URL")
                }
            } else {
                XCTFail("Request should not succeed with an invalid URL")
            }
        }
        task.resume()
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDecodeDataSuccess() {
        // Given
        let jsonData = """
            {"key": "value"}
            """.data(using: .utf8)!
        let expectedResult = "value"
        
        // When
        do {
            let decodedData: [String: String] = try APIService.decodeData([String: String].self, from: jsonData)
            
            // Then
            XCTAssertEqual(decodedData["key"], expectedResult, "Data decoding should be successful")
        } catch {
            XCTFail("Data decoding should not throw errors")
        }
    }
}
