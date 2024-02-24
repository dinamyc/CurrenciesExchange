//
//  Constants.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

struct Constants {
    struct API {
        static let currenciesBaseURL = "https://waseemtabrez.github.io/CurrencyTest/CurrencyList.json"
    }
    
    struct ContentView {
        static let mainTitle = "Currencies"
        static let firstTabTitle = "Currency List"
        static let secondTabTitle = "Currency Exchange"
        static let exchangeTitle = "Exchange"
    }
    
    struct CurrencyDetailView {
        static let detailTitle = "Currency Detail"
        static let detailName = "Currency List"
        static let detailCode = "Currency Exchange"
    }
    
    struct CurrencyRow {
        static let detailName = "Currency Name"
        static let detailCode = "Currency Code"
    }
    
    struct CurrencyExchangeView {
        static let baseCurrencyTitle = "Currency Name"
        static let enterAmount = "Enter Amount"
    }
    
    struct EmptyStateView {
        static let title = "No currencies available"
        static let description = "Please check back later."
        static let buttonTitle = "Reload"
    }
}
