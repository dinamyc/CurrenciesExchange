//
//  CurrencyExchangeViewModelTests.swift
//  CitiCodeChallengeTests
//
//  Created by JL on 23/02/24.
//

import XCTest
import SwiftUI

@testable import CitiCodeChallenge

final class CurrencyExchangeViewModelTests: XCTestCase {
    
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
    
    // Currency Conversion Test when the amount is valid
    func testExchangedAmountForValidAmount() {
        let viewModel = CurrencyExchangeViewModel(currencies: currencies)
        viewModel.baseCurrencyIndex = 0 // USD as base currency
        viewModel.amount = "100.0"
        
        // Verify exchanged amount is correct for EUR
        let exchangedAmountEUR = viewModel.exchangedAmountForCurrency(at: 1)
        XCTAssertEqual(exchangedAmountEUR, "82.00")
        
        // Verify exchanged amount is correct for GBP
        let exchangedAmountGBP = viewModel.exchangedAmountForCurrency(at: 2)
        XCTAssertEqual(exchangedAmountGBP, "72.00")
    }
    
    // Currency Conversion Test when the amount is invalid
    func testExchangedAmountForInvalidAmount() {
        let viewModel = CurrencyExchangeViewModel(currencies: currencies)
        viewModel.baseCurrencyIndex = 0 // USD as base currency
        viewModel.amount = "invalid"
        
        // Verify "No exchange rate available" is returned for EUR
        let exchangedAmountEUR = viewModel.exchangedAmountForCurrency(at: 1)
        XCTAssertEqual(exchangedAmountEUR, "No exchange rate available")
        
        // Verify "No exchange rate available" is returned for GBP
        let exchangedAmountGBP = viewModel.exchangedAmountForCurrency(at: 2)
        XCTAssertEqual(exchangedAmountGBP, "No exchange rate available")
    }
    
    // Currency Conversion Test with decimal amount
    func testExchangedAmountForDecimalAmount() {
        let viewModel = CurrencyExchangeViewModel(currencies: currencies)
        viewModel.baseCurrencyIndex = 0 // USD as base currency
        viewModel.amount = "50.75"
        
        // Verify exchanged amount for EUR with decimal amount
        let exchangedAmountEUR = viewModel.exchangedAmountForCurrency(at: 1)
        XCTAssertEqual(exchangedAmountEUR, "41.61")
        
        // Verify exchanged amount for GBP with decimal amount
        let exchangedAmountGBP = viewModel.exchangedAmountForCurrency(at: 2)
        XCTAssertEqual(exchangedAmountGBP, "36.54")
    }
    
    // Base Currency Update Test
    func testUpdateBaseCurrencyIndex() {
        let viewModel = CurrencyExchangeViewModel(currencies: currencies)
        viewModel.baseCurrencyIndex = 0 // USD as base currency
        XCTAssertEqual(viewModel.baseCurrencyIndex, 0)
        
        viewModel.baseCurrencyIndex = 1 // EUR as base currency
        XCTAssertEqual(viewModel.baseCurrencyIndex, 1)
        
        viewModel.baseCurrencyIndex = 2 // GBP as base currency
        XCTAssertEqual(viewModel.baseCurrencyIndex, 2)
    }
    
    // Amount Update Test
    func testUpdateAmount() {
        let viewModel = CurrencyExchangeViewModel(currencies: currencies)
        viewModel.amount = "100.0"
        XCTAssertEqual(viewModel.amount, "100.0")
        
        viewModel.amount = "50.75"
        XCTAssertEqual(viewModel.amount, "50.75")
        
        viewModel.amount = "invalid"
        XCTAssertEqual(viewModel.amount, "invalid")
    }
}

