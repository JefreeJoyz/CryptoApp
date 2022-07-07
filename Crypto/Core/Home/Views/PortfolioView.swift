//
//  PortfolioView.swift
//  Crypto
//
//  Created by Eugene Yakushev on 29.06.2022.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading, spacing: 0) {
                    SearchBarView(searchtext: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    //XmarkButton() // по хорошему, здесь должна быть только эта строчка. Мы создали отдельный компонент, который хотим переиспользовать и на других экранах. Но в xcode Version 13.4.1 (13F100) вьюха отображается, но не отрабатывает закрытие sheet. 
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingBarButtons
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin (coin: CoinModel) {
        selectedCoin = coin
       if let portfolioCoins = vm.portfolioCoins.first(where:  { $0.id == coin.id} ),
          let amount = portfolioCoins.currentHoldings {
           quantityText = "\(amount)"
       } else {
           quantityText = ""
       }
    }
    
    private func getCurrentValue () -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrancyWithSixDecimals() ?? "")
            }
            
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex. 1.6", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrancyWith2Decimals())
            }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
    
    private var trailingBarButtons: some View {
        HStack (spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed ()
            } label: {
                Text("Save".uppercased())
            }
            // юзер выбрал валюту? selectedCoin
            // currentHoldings юзера совпадает с указанным в текстФилде?
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0 )
        }
    }
    
    private func saveButtonPressed () {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save
        vm.updatePortfolio(coin: coin, amount: amount)
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        // hide the keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin () {
        selectedCoin = nil
        vm.searchText = ""
    }
}
