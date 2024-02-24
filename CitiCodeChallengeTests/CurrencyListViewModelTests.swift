//
//  CurrencyListViewModelTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class CurrencyListViewModelTests: XCTestCase {
    
    // Success Test when retrieving currency list
    func testFetchCurrenciesSuccess() throws {
        
        let jsonData = """
                    {
                        "code": "USD",
                        "name": "US Dollar",
                        "tradeValue": 0.82,
                        "flagURL": "https://example.com/flag.png"
                    }
                    """.data(using: .utf8)!
        
        // When
        let currency = try JSONDecoder().decode(Currency.self, from: jsonData)
        // Given
        let viewModel = CurrencyListViewModel()
        let expectation = XCTestExpectation(description: "Fetch Currencies")
        
        // When
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            viewModel.currencies = [currency]
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 2.0)
    }
    
}

