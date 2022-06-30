//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Eugene Yakushev on 20.06.2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDatService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        addSubscribers ()
    }
    
    func addSubscribers () {
        
        $searchText
            .combineLatest(coinDataService.$allCoins) // теперь мы подписаны на $searchText и $allCoins
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // для Core Data
        // Подписываемся на отфильтрованный $allCoins, потому что фильтр нам нужен будет и для этих данных
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (CoinModel, portfolioEntity) -> [CoinModel] in
                CoinModel
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntity.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHolding(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)

    }
    
    func updatePortfolio (coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins (text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData (marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else { return stats }
       let marketCap = StatisticModel(title: "marketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
       stats.append(marketCap)
       
       let volume = StatisticModel(title: "24h volume", value: data.volume)
       stats.append(volume)
       let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
       stats.append(btcDominance)
       let portfolio = StatisticModel(title: "Portfolio value", value: "$0.00", percentageChange: 0)
       stats.append(portfolio)
       
       // Альтернативная запись поштучного добавления
//                stats.append([
//                marketCap, volume, btcDominance, portfolio
//                ])
       return stats
    }
}
