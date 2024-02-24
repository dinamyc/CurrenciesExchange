//
//  CurrencyRow.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import SwiftUI

struct CurrencyRow: View {
    let currency: Currency
    
    var body: some View {
        HStack {
            HelperImage().asyncImageView(with: currency.flagURL)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                .padding(.trailing, 10)
                .accessibility(label: Text("Currency Flag"))
            
            VStack(alignment: .leading) {
                Text(currency.name)
                    .font(.headline)
                    .accessibility(label: Text("\(Constants.CurrencyRow.detailName) \(currency.name)"))
                
                Text(currency.code)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .accessibility(label: Text("\(Constants.CurrencyRow.detailCode) \(currency.code)"))
            }
            
            Spacer()
        }
        .padding()
        .accessibility(identifier: "CurrencyRow") // Agregado para la accesibilidad
    }
}
