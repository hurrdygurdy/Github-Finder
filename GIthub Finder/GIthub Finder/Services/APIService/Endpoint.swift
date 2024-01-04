//
//  Endpoint.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import Foundation

private let token = ""

enum Endpoint {
    case listUsers
    case getUser(String)
    case avatar(link: String)
    
    var url: URL? {
        switch self {
        case .listUsers:
            return URL(string: "https://api.github.com/users/")
        case .getUser(let username):
            return URL(string: "https://api.github.com/users/\(username)")
        case .avatar(let link):
            return URL(string: link)
        }
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        switch self {
        case .listUsers, .getUser:
            request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        default: break
        }
        return request
    }
}
