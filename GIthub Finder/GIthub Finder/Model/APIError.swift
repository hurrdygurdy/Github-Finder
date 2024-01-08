//
//  APIError.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import Foundation

enum APIError: Error {
    case requestCreationFailed
    case requestFailed(Error)
    case invalidResponseCode(Int)
    case emptyResponseData
    case any(Error)
    
    var info: String {
        switch self {
        case .requestCreationFailed:
            return "ERR_100: Could not create a request at the moment"
        case .requestFailed(let error):
            return "ERR_101: Request failed with error: \(error.localizedDescription)"
        case .invalidResponseCode(let int):
            return "ERR_102: Invalid response code \(int)"
        case .emptyResponseData:
            return "ERR_103: Oops!!! Empty response"
        case .any(let error):
            return "ERR_104: \(error.localizedDescription)"
        }
    }
}
