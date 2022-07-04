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
    // мы не можем иниировать DetailViewModel, т.к. неоткуда взять аргумент coin. Поэтому мы делаем это через init
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing detail view \(coin.name)")
    }
    
    var body: some View {
        ZStack {
            Text("hello")
        }
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            DetailView(coin: dev.coin)
        }
    }
}
