//
//  CurrencyTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class CurrencyTests: XCTestCase {
    
    func testCurrencyInitialization() throws {
        // Given
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
        
        // Then
        XCTAssertEqual(currency.code, "USD", "Currency code does not match")
        XCTAssertEqual(currency.name, "US Dollar", "Currency name does not match")
        XCTAssertEqual(currency.flagURL, URL(string: "https://example.com/flag.png"), "Currency flag URL does not match")
    }
    
    func testCurrencyListViewModelFetchCurrencies() {
        // Given
        let viewModel = CurrencyListViewModel()
        let expectation = XCTestExpectation(description: "Fetch Currencies")
        
        // When
        viewModel.fetchCurrencies()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(viewModel.currencies.isEmpty, "Currency list should not be empty after fetching")
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCurrencyDetailViewModelInitialization() throws {
        // Given
        let jsonData = """
        {
            "code": "USD",
            "name": "US Dollar",
            "flagURL": "https://example.com/flag.png",
            "tradeValue": 0.82
        
        }
        """.data(using: .utf8)!
        
        // When
        let currency = try JSONDecoder().decode(Currency.self, from: jsonData)
        
        // When
        let viewModel = CurrencyDetailViewModel(currency: currency)
        
        // Then
        XCTAssertNotNil(viewModel, "Currency detail ViewModel should not be nil")
        XCTAssertEqual(viewModel.currency, currency, "Currency detail ViewModel should contain the provided currency")
        // Add more assertions based on your ViewModel's specific logic.
    }
    
    func testCurrencyServiceFetchCurrencies() {
        // Given
        let service = CurrencyService()
        let expectation = XCTestExpectation(description: "Fetch Currencies")
        
        // When
        service.fetchCurrencies { result in
            switch result {
            case .success(let currencies):
                // Then
                XCTAssertFalse(currencies.isEmpty, "No currencies were received")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch currencies with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
