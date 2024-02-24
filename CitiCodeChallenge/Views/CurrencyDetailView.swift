//
//  CurrencyDetailView.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation
import SwiftUI

struct CurrencyDetailView: View {
    @ObservedObject var viewModel: CurrencyDetailViewModel
    
    init(currency: Currency) {
        self.viewModel = CurrencyDetailViewModel(currency: currency)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Constants.CurrencyDetailView.detailTitle)
                .font(.title)
                .fontWeight(.bold)
                .accessibility(identifier: "currencyDetailTitle")
            
            HelperImage().asyncImageView(with: viewModel.currency.flagURL)
                .frame(width: 120, height: 80)
                .padding(.bottom, 20)
                .accessibility(identifier: "currencyFlagImage")
            
            VStack(spacing: 10) {
                Text(Constants.CurrencyDetailView.detailName)
                    .font(.headline)
                Text(viewModel.currency.name)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            VStack(spacing: 10) {
                Text(Constants.CurrencyDetailView.detailCode)
                    .font(.headline)
                Text(viewModel.currency.code)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .accessibility(identifier: "currencyDetail")
    }
}
