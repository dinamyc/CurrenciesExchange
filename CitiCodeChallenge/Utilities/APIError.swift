//
//  APIError.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.networkError(error1), .networkError(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case (.invalidResponse, .invalidResponse):
            return true
        case let (.decodingError(error1), .decodingError(error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}
