//
//  CurrencyService.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

// Service for fetching currencies from API
class CurrencyService {
    let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchCurrencies(completion: @escaping (Result<[Currency], APIError>) -> Void) {
        guard let url = URL(string: Constants.API.currenciesBaseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        apiService.request(url: url) { (result: Result<CurrencyListResponse, APIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.currencies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
