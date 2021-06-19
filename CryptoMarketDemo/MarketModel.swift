//
//  MarketModel.swift
//  CryptoMarketDemo
//
//  Created by Ruchin Somal on 2021-06-19.
//

import Foundation
struct Market: Codable {
    let data: [MarketElement]
    let timestamp: Double?
    
    private enum CodingKeys: String, CodingKey {
        case data, timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timestamp = try container.decode(Double.self, forKey: .timestamp)
        self.data = try container.decode([MarketElement].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(data, forKey: .data)
    }
}

struct MarketElement: Codable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    let changePercent24Hr: String
    let vwap24Hr: String?
    let explorer: String
    
    private enum CodingKeys: String, CodingKey {
        case id, rank, symbol, name, supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr, explorer
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.rank = try container.decode(String.self, forKey: .rank)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.name = try container.decode(String.self, forKey: .name)
        self.supply = try container.decode(String.self, forKey: .supply)
        self.maxSupply = try? container.decode(String.self, forKey: .maxSupply)
        self.marketCapUsd = try container.decode(String.self, forKey: .marketCapUsd)
        self.volumeUsd24Hr = try container.decode(String.self, forKey: .volumeUsd24Hr)
        self.priceUsd = try container.decode(String.self, forKey: .priceUsd)
        self.changePercent24Hr = try container.decode(String.self, forKey: .changePercent24Hr)
        self.vwap24Hr = try? container.decode(String.self, forKey: .vwap24Hr)
        self.explorer = try container.decode(String.self, forKey: .explorer)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(rank, forKey: .rank)
        try container.encode(name, forKey: .name)
        try container.encode(supply, forKey: .supply)
        try container.encode(maxSupply, forKey: .maxSupply)
        try container.encode(marketCapUsd, forKey: .marketCapUsd)
        try container.encode(volumeUsd24Hr, forKey: .volumeUsd24Hr)
        try container.encode(priceUsd, forKey: .priceUsd)
        try container.encode(changePercent24Hr, forKey: .changePercent24Hr)
        try container.encode(vwap24Hr, forKey: .vwap24Hr)
        try container.encode(explorer, forKey: .explorer)
    }
}
