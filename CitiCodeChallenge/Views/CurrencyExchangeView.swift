
import SwiftUI

import SwiftUI

struct CurrencyExchangeView: View {
    @ObservedObject var viewModel: CurrencyExchangeViewModel
    
    init(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Picker(Constants.CurrencyExchangeView.baseCurrencyTitle, selection: $viewModel.baseCurrencyIndex) {
                ForEach(0..<viewModel.currencies.count, id: \.self) { index in
                    Text("\(viewModel.currencies[index].name) (\(viewModel.currencies[index].code))")
                        .tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
        
            TextField(Constants.CurrencyExchangeView.enterAmount, text: $viewModel.amount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            List(0..<viewModel.currencies.count, id: \.self) { index in
                let exchangedAmount = viewModel.exchangedAmountForCurrency(at: index)
                Text("\(viewModel.currencies[index].name) (\(viewModel.currencies[index].code)): $\(exchangedAmount)")
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            if !viewModel.currencies.isEmpty {
                viewModel.baseCurrencyIndex = 0
            }
        }
    }
}
