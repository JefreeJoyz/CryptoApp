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
    @Published var isLoading: Bool = false
    
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
        
        // для Core Data
        // Подписываемся на отфильтрованный $allCoins, потому что фильтр нам нужен будет и для этих данных
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio (coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData () {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
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
    
    private func mapAllCoinsToPortfolioCoins(allcoins: [CoinModel], portfolioEntity: [PortfolioEntity]) -> [CoinModel] {
        allcoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntity.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHolding(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData (marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else { return stats }
       let marketCap = StatisticModel(title: "marketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
       stats.append(marketCap)
       
       let volume = StatisticModel(title: "24h volume", value: data.volume)
       stats.append(volume)
       let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
       stats.append(btcDominance)
        
        let portfolioValue = portfolioCoins.map { coin -> Double in // portfolioCoins приходит к нам с типом [CoinModel]. Здесь же мы ясно говорим, что у него будет тип дабл
            return coin.currentHoldingValue
        }
            .reduce(0, +) // а это вроде как функция, которая позволяет просуммировать, но в нашем примере мы [double] превратили double
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingValue
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio value", value: portfolioValue.asCurrancyWith2Decimals(), percentageChange: percentageChange)
       stats.append(portfolio)
       
       // Альтернативная запись поштучного добавления
//                stats.append([
//                marketCap, volume, btcDominance, portfolio
//                ])
       return stats
    }
}
