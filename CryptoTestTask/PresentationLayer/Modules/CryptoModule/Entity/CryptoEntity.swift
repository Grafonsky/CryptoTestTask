//
//  CryptoEntity.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

struct CryptoEntity: Codable {
    var id: String
    var name: String
    var image: String
    var current_price: Double
    var market_cap: Double
    var isFavorite: Bool?
}
