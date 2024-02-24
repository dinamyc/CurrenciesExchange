//
//  CurrencyListViewModel.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

class CurrencyListViewModel: ObservableObject {
    @Published var currencies: [Currency] = []
    @Published var isLoading = false
    
    let currencyService: CurrencyService
    
    init(currencyService: CurrencyService = CurrencyService()) {
        self.currencyService = currencyService
    }
    
    func fetchCurrencies() {
        isLoading = true
        currencyService.fetchCurrencies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let currencies):
                    self?.currencies = currencies
                case .failure(let error):
                    print("Failed to fetch currencies: \(error)")
                }
            }
        }
    }
}
