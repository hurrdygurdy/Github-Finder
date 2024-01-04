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
}
