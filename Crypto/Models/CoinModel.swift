//
//  CoinModel.swift
//  Crypto
//
//  Created by Eugene Yakushev on 17.06.2022.
//

// Json response
/*
 
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 21109,
     "market_cap": 404766132176,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 445739692086,
     "total_volume": 28613003893,
     "high_24h": 21776,
     "low_24h": 20283,
     "price_change_24h": -660.6463653040955,
     "price_change_percentage_24h": -3.0347,
     "market_cap_change_24h": -11472847644.324951,
     "market_cap_change_percentage_24h": -2.75631,
     "circulating_supply": 19069625,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 69045,
     "ath_change_percentage": -69.31354,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 67.81,
     "atl_change_percentage": 31145.6984,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2022-06-17T08:51:23.600Z",
     "sparkline_in_7d": {
       "price": [
         30135.269191569547,
         30108.66171405935,
         20578.244771455087
       ]
     },
     "price_change_percentage_24h_in_currency": -3.0347041452883317
   }
 
 */

// Везде Инт заменено на Дабл, потому что "Я знаю, оно приходит как дабл" (с)

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double? // мы не получаем этот параметр в респонсе
    
    enum CodingKeys: String, CodingKey {
       case id, symbol, name, image
       case currentPrice = "current_price"
       case marketCap = "market_cap"
       case marketCapRank = "market_cap_rank"
       case fullyDilutedValuation = "fully_diluted_valuation"
       case totalVolume = "total_volume"
       case high24H = "high_24h"
       case low24H = "low_24h"
       case priceChange24H = "price_change_24h"
       case priceChangePercentage24H = "price_change_percentage_24h"
       case marketCapChange24H = "market_cap_change_24h"
       case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
       case circulatingSupply = "circulating_supply"
       case totalSupply = "total_supply"
       case maxSupply = "max_supply"
       case ath
       case athChangePercentage = "ath_change_percentage"
       case athDate = "ath_date"
       case atl
       case atlChangePercentage = "atl_change_percentage"
       case atlDate = "atl_date"
       case lastUpdated = "last_updated"
       case sparklineIn7D = "sparkline_in_7d"
       case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
   }
    // Делаем для того, что бы каждый раз, когда вызывается CoinModel, апдейтился currentHoldings
    // amount - какое кол-во мы имеем уже сейчас
    func updateHolding (amount: Double) -> CoinModel { // возвращать будет обновленную CoinModel
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
