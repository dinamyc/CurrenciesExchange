//
//  CurrencyDetailViewModel.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

class CurrencyDetailViewModel: ObservableObject {
    @Published var currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
}
