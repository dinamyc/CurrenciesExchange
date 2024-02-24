//
//  Currency.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

// Model for Currency
struct CurrencyListResponse: Decodable {
    let currencies: [Currency]
}

// Model for CurrencyResponse
struct CurrencyResponse: Decodable {
    let currencies: [Currency]
}

struct Currency: Identifiable, Decodable, Hashable {
    let id = UUID()
    let code: String
    let name: String
    let tradeValue: Double?
    let flagURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case code, name, flagURL
        case country
        case tradeValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        tradeValue = try container.decode(Double.self, forKey: .tradeValue)
        
        // Decode the flag URL as a string
        let urlString = try container.decode(String.self, forKey: .flagURL)
        flagURL = urlString.isEmpty ? nil : URL(string: urlString)
    }
}
