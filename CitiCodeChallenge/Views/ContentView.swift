//
//  ContentView.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import SwiftUI

// Main ContentView
struct ContentView: View {
    @ObservedObject var currencyListViewModel = CurrencyListViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                // Use a conditional view to display either the list of currencies or the empty state
                if currencyListViewModel.currencies.isEmpty {
                    VStack {
                        ActivityIndicator() // Spinner
                            .frame(width: 50, height: 50)
                        Text("Loading currencies...")
                    }
                    .navigationBarTitle(Constants.ContentView.firstTabTitle)
                    .accessibility(identifier: "loadingView")
                } else {
                    CurrencyListView(viewModel: currencyListViewModel)
                        .navigationBarTitle(Constants.ContentView.firstTabTitle)
                        .accessibility(identifier: "currencyListView")
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text(Constants.ContentView.mainTitle)
            }
            .tag(0)
            
            NavigationView {
                CurrencyExchangeView(viewModel: CurrencyExchangeViewModel(currencies: currencyListViewModel.currencies))
                    .navigationBarTitle(Constants.ContentView.secondTabTitle)
                    .accessibility(identifier: "currencyExchangeView")
                    // Disable tapp
                    .disabled(currencyListViewModel.currencies.isEmpty)
                    // Show an overlay with an error message if there is an error
            }
            .tabItem {
                Image(systemName: "arrow.triangle.2.circlepath")
                Text(Constants.ContentView.exchangeTitle)
            }
            .tag(1)
        }
        .onAppear {
            self.currencyListViewModel.fetchCurrencies()
        }
        .accessibility(identifier: "contentView")
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
