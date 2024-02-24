//
//  CurrencyExchangeViewTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class CurrencyExchangeViewTests: XCTestCase {
    // Mock Currency
    let usdData = """
    {
        "code": "USD",
        "name": "US Dollar",
        "tradeValue": 1.0,
        "flagURL": "https://example.com"
    }
    """.data(using: .utf8)!
    
    let eurData = """
    {
        "code": "EUR",
        "name": "Euro",
        "tradeValue": 0.82,
        "flagURL": "https://example.com"
    }
    """.data(using: .utf8)!
    
    let gbpData = """
    {
        "code": "GBP",
        "name": "British Pound",
        "tradeValue": 0.72,
        "flagURL": "https://example.com"
    }
    """.data(using: .utf8)!
    
    lazy var currencies: [Currency] = {
        do {
            let usd = try JSONDecoder().decode(Currency.self, from: usdData)
            let eur = try JSONDecoder().decode(Currency.self, from: eurData)
            let gbp = try JSONDecoder().decode(Currency.self, from: gbpData)
            return [usd, eur, gbp]
        } catch {
            fatalError("Error initializing currencies: \(error)")
        }
    }()
    
    func testCurrencyExchangeView_Initialization() {
        // Given
        let viewModel = CurrencyExchangeViewModel(currencies: currencies)
        
        // When
        let view = CurrencyExchangeView(viewModel: viewModel)
        
        // Then
        XCTAssertNotNil(view)
    }
    
    func testCurrencyExchangeView() throws {
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
        let viewModel = CurrencyExchangeViewModel(currencies: [currency]) // O crea una instancia de tu viewModel
        let currencyExchangeView = CurrencyExchangeView(viewModel: viewModel)
        
        // When
        let result = currencyExchangeView.body
        
        // Then
        XCTAssertNotNil(result)
    }
}


