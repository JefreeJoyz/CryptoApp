//
//  DetailView.swift
//  Crypto
//
//  Created by Eugene Yakushev on 04.07.2022.
//

import SwiftUI

// Эта вьюха-прокладка нужна для того, что бы наша DetailView() не инициилизировалась раньше времени
struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            // Т.к. coin у нас опционал - безопасно извлекаем
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initializing detail view \(coin.name)")
    }
    
    var body: some View {
        ZStack {
            Text(coin.name)
        }
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            DetailView(coin: dev.coin)
        }
    }
}
