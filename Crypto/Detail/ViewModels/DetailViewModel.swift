//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Eugene Yakushev on 04.07.2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init (coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscrubiers ()
    }
    
    private func addSubscrubiers () {
        
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
        
    }
}
