//
//  CurrencyListView.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import SwiftUI

struct CurrencyListView: View {
    @ObservedObject var viewModel: CurrencyListViewModel
    
    var body: some View {
        List(viewModel.currencies) { currency in
            NavigationLink(destination: CurrencyDetailView(currency: currency)) {
                CurrencyRow(currency: currency)
                    .accessibility(identifier: "currencyRow_\(currency.id)")
            }
            .accessibility(label: Text("Currency \(currency.name)"))
        }
        .onAppear {
            viewModel.fetchCurrencies()
        }
        .accessibility(identifier: "currencyList")
    }
}
