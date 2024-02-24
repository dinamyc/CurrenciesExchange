//
//  ResultTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

// Result Enum Tests
final class ResultTests: XCTestCase {
    
    // Success Case Test
    func testSuccessCase() {
        let result: Result<Int, Error> = .success(5)
        if case .success(let value) = result {
            XCTAssertEqual(value, 5, "Success case value does not match")
        } else {
            XCTFail("Expected a success case, but got a failure case")
        }
    }
    
    // Failure Case Test
    func testFailureCase() {
        let error = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        let result: Result<Int, Error> = .failure(error)
        switch result {
        case .success(_):
            XCTFail("Expected a failure case, but got a success case")
        case .failure(let receivedError):
            XCTAssertEqual(receivedError as NSError, error, "Failure case error does not match")
        }
    }
    
    enum TestError: Error {
        case testError
    }
    
    // Success Case Test with String Data Type
    func testSuccessWithString() {
        let successResult: Result<String, TestError> = .success("Hello")
        switch successResult {
        case .success(let value):
            XCTAssertEqual(value, "Hello", "Success case value does not match the expected value")
        case .failure(_):
            XCTFail("Expected a success case, but got a failure case")
        }
    }
    
    // Failure Case Test with Double Data Type
    func testFailureWithDouble() {
        let error = TestError.testError
        let failureResult: Result<Double, TestError> = .failure(error)
        if case .failure(let receivedError) = failureResult {
            XCTAssertEqual(receivedError, error, "Failure case error does not match the expected error")
        } else {
            XCTFail("Expected a failure case, but got a success case")
        }
    }
}
