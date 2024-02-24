//
//  APIService.swift
//  CitiCodeChallenge
//
//  Created by JL on 23/02/24.
//

import Foundation

enum Result<T, E> {
    case success(T)
    case failure(E)
}

struct ResponseValidator {
    static func validateResponse(_ response: URLResponse?) -> APIError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            return .invalidResponse
        }
        
        return nil
    }
}

final class APIService {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let responseError = ResponseValidator.validateResponse(response) {
                completion(.failure(responseError))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try APIService.decodeData(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    static func decodeData<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}


protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
