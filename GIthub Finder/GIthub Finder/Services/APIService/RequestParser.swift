//
//  UserRequestParser.swift
//  GIthub Finder
//
//  Created by UserTest on 08/01/24.
//

import Foundation

protocol RequestParser {
    /// Protocol into which response should be decoded
    var decodable: Decodable.Type { get }
    /// Fetching completed successfully. `result` is of type `decodable`
    func fetchDidCompleteWith(result: Decodable)
    /// Fetching failed.
    func fetchFailedWith(error: APIError)
}

extension RequestParser {
    func completionHandler(_ apiResponse: APIResponse) {
        switch apiResponse {
        case .success(let data):
            do {
                let result = try Global.jsonDecoder.decode(decodable, from: data)
                fetchDidCompleteWith(result: result)
            } catch {
                fetchFailedWith(error: APIError.any(error))
            }
        case .failure(let error):
            fetchFailedWith(error: error)
        }
    }
}
