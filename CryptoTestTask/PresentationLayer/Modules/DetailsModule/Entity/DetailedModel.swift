//
//  DetailedEntity.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

struct DetailedModel: Codable {
    var symbol: String?
    var name: String?
    var image: Image?
    var genesis_date: String?
    var market_data: MarketData?
}

struct Image: Codable {
    var large: String
}

struct MarketData: Codable {
    var current_price: CurrentPrice
    var high_24h: HighPerDay?
    var low_24h: LowPerDay?
    var market_cap: TotalVolume?
}

struct CurrentPrice: Codable {
    var usd: Double
}

struct HighPerDay: Codable {
    var usd: Double
}

struct LowPerDay: Codable {
    var usd: Double
}

struct TotalVolume: Codable {
    var usd: Double
}
