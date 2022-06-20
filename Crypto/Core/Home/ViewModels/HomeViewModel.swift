//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Eugene Yakushev on 20.06.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init () {
        // Симуляция скачивания с инета
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
    
}
