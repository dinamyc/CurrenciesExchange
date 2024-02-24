//
//  CurrencyExchangeViewModel.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

class CurrencyExchangeViewModel: ObservableObject {
    @Published var baseCurrencyIndex = 0
    @Published var amount: String = "0.0"
    
    var currencies: [Currency]
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func exchangedAmountForCurrency(at index: Int) -> String {
        let baseRate = currencies[baseCurrencyIndex].tradeValue
        let selectedRate = currencies[index].tradeValue
        guard let baseRate = baseRate, let selectedRate = selectedRate, let amount = Double(amount) else {
            return "No exchange rate available"
        }
        let exchangedAmount = (amount / baseRate) * selectedRate
        return String(format: "%.2f", exchangedAmount)
    }
}
