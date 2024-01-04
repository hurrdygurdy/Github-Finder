//
//  GithubAPI.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import Foundation

typealias APIResponse = Result<Data, APIError>

extension Endpoint {
    func request(completion: @escaping (APIResponse) -> Void) {
        guard let request = self.urlRequest else {
            return completion(.failure(.requestCreationFailed))
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                return completion(.failure(.requestFailed(err)))
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return completion(.failure(.invalidResponseCode(httpResponse.statusCode)))
            } else if let data = data {
                return completion(.success(data))
            } else {
                return completion(.failure(.emptyResponseData))
            }
        }.resume()
    }
}

