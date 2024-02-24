//
//  ResponseValidatorTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

class ResponseValidatorTests: XCTestCase {
    
    func testValidateResponse_ValidResponse() {
        // Given
        let validResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)
        
        // When
        let error = ResponseValidator.validateResponse(validResponse)
        
        // Then
        XCTAssertNil(error, "No error should be returned for a valid response")
    }
    
    func testValidateResponse_InvalidResponse() {
        // Given
        let invalidResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                              statusCode: 404,
                                              httpVersion: nil,
                                              headerFields: nil)
        
        // When
        let error = ResponseValidator.validateResponse(invalidResponse)
        
        // Then
        XCTAssertEqual(error, .invalidResponse, "An error should be returned for an invalid response")
    }
    
    func testValidateResponse_NilResponse() {
        // When
        let error = ResponseValidator.validateResponse(nil)
        
        // Then
        XCTAssertEqual(error, .invalidResponse, "An error should be returned for a nil response")
    }
    
    // Valid Response Test
    func testValidResponse() {
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        XCTAssertNil(ResponseValidator.validateResponse(httpResponse), "Response should be valid")
    }
    
    // Invalid Response Test
    func testInvalidResponse() {
        let httpResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 404,
                                           httpVersion: nil,
                                           headerFields: nil)
        XCTAssertEqual(ResponseValidator.validateResponse(httpResponse), .invalidResponse, "Response should be invalid")
    }
    
    // Non-HTTPURLResponse Test
    func testNonHTTPURLResponse() {
        let response = URLResponse(url: URL(string: "https://example.com")!,
                                   mimeType: nil,
                                   expectedContentLength: 0,
                                   textEncodingName: nil)
        XCTAssertEqual(ResponseValidator.validateResponse(response), .invalidResponse, "Response should be invalid")
    }
    
    // Nil Response Test
    func testNilResponse() {
        XCTAssertNotNil(ResponseValidator.validateResponse(nil), "Response should be invalid")
    }
}
