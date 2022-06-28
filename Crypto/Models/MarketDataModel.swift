//
//  MarketDataModel.swift
//  Crypto
//
//  Created by Eugene Yakushev on 28.06.2022.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/global
 
 {
   "data": {
     "active_cryptocurrencies": 13385,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 526,
     "total_market_cap": {
       "btc": 47016770.64339897,
       "eth": 809369929.0568688,
       "ltc": 17601333925.95641,
       "bch": 8815742521.88103,
       "bnb": 4130736260.2303896,
       "eos": 992897513198.3878,
       "xrp": 2802224734243.504,
       "xlm": 8238088590690.933,
       "link": 148572570941.8428,
       "dot": 127081074964.9148,
       "yfi": 159831734.6635252,
       "usd": 991718974034.9617,
       "aed": 3642598667415.0327,
       "ars": 123634388348306.12,
       "aud": 1424903805331.3848,
       "bdt": 92253909803496.23,
       "bhd": 373897887590.66223,
       "bmd": 991718974034.9617,
       "brl": 5195615704969.195,
       "cad": 1271723884320.9167,
       "chf": 946238741885.7202,
       "clp": 912966570306847.1,
       "cny": 6631525607474.406,
       "czk": 23158674042770.086,
       "dkk": 6966838684942.272,
       "eur": 936316593550.4999,
       "gbp": 807334615506.486,
       "hkd": 7781865072811.381,
       "huf": 375371452070892.25,
       "idr": 14706000696742290,
       "ils": 3390044538330.3643,
       "inr": 78120185857326.17,
       "jpy": 134558711350704.06,
       "krw": 1274062381462946.5,
       "kwd": 304100706198.0811,
       "lkr": 357305943212759.7,
       "mmk": 1837650862596577.5,
       "mxn": 19748638433361.117,
       "myr": 4360588328831.7363,
       "ngn": 416609608292139.2,
       "nok": 9686015088907.193,
       "nzd": 1573619999239.7195,
       "php": 54250003036634.5,
       "pkr": 205898442187068.2,
       "pln": 4399885193177.869,
       "rub": 52709868428553.42,
       "sar": 3722451879204.329,
       "sek": 9960142080834.06,
       "sgd": 1373326484929.7742,
       "thb": 34804259379199.14,
       "try": 16501013665172.947,
       "twd": 29415873340057.066,
       "uah": 29322720185106.97,
       "vef": 99300820870.12077,
       "vnd": 23065399898105170,
       "zar": 15744343988611.986,
       "xdr": 724138319055.7177,
       "xag": 46605525751.89118,
       "xau": 542916552.335439,
       "bits": 47016770643398.97,
       "sats": 4701677064339897
     },
     "total_volume": {
       "btc": 3821806.5272306497,
       "eth": 65790466.58212018,
       "ltc": 1430742519.4382393,
       "bch": 716596692.0197226,
       "bnb": 335771142.62808824,
       "eos": 80708694895.13608,
       "xrp": 227781717747.61374,
       "xlm": 669641498490.0133,
       "link": 12076874137.094599,
       "dot": 10329915796.898462,
       "yfi": 12992086.832773978,
       "usd": 80612896127.8932,
       "aed": 296092376671.19434,
       "ars": 10049748332642.322,
       "aud": 115824770382.34952,
       "bdt": 7498953880173.613,
       "bhd": 30392674098.138374,
       "bmd": 80612896127.8932,
       "brl": 422330962814.03503,
       "cad": 103373383059.33112,
       "chf": 76915988711.46819,
       "clp": 74211426046377.34,
       "cny": 539050375117.6107,
       "czk": 1882476622862.0598,
       "dkk": 566306643266.0997,
       "eur": 76109456685.70856,
       "gbp": 65625024028.21083,
       "hkd": 632556900916.6792,
       "huf": 30512454301495.004,
       "idr": 1195392381976770,
       "ils": 275563254704.5764,
       "inr": 6350079602073.174,
       "jpy": 10937743156293.658,
       "krw": 103563470203110.19,
       "kwd": 24719138468.65721,
       "lkr": 29043980845599.594,
       "mmk": 149375339168018.03,
       "mxn": 1605288373397.3367,
       "myr": 354454904274.3472,
       "ngn": 33864540215958.93,
       "nok": 787337692127.0392,
       "nzd": 127913319059.89612,
       "php": 4409767256884.142,
       "pkr": 16736666502799.018,
       "pln": 357649190283.4148,
       "rub": 4284575832262.0317,
       "sar": 302583327067.41235,
       "sek": 809620386423.1285,
       "sgd": 111632254880.53003,
       "thb": 2829099996673.7783,
       "try": 1341301856092.7917,
       "twd": 2391099499110.4067,
       "uah": 2383527449164.2163,
       "vef": 8071769289.285951,
       "vnd": 1874894738142542.5,
       "zar": 1279795183701.9648,
       "xdr": 58862327559.14564,
       "xag": 3788378063.5325503,
       "xau": 44131529.98521507,
       "bits": 3821806527230.65,
       "sats": 382180652723065
     },
     "market_cap_percentage": {
       "btc": 40.579694732136346,
       "eth": 14.989873405233379,
       "usdt": 6.745324753967785,
       "usdc": 5.687059373736843,
       "bnb": 3.954893519101985,
       "busd": 1.7665095203882357,
       "xrp": 1.7257532747949909,
       "ada": 1.681986861296105,
       "sol": 1.3548443927395408,
       "doge": 0.9742560093282062
     },
     "market_cap_change_percentage_24h_usd": -1.3295118040850928,
     "updated_at": 1656407028
   }
 }
 */
    
struct GlobalData: Codable {
        let data: MarketDataModel?
}

struct MarketDataModel: Codable {
        let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
        let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}

