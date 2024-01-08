//
//  Endpoint.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import Foundation

private let token = "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"

enum Endpoint {
    case listUsers
    case getUser(String)
    case avatar(link: String)
    case followers(ofUser: String)
    case usersFollowed(byUser: String)
    
    var url: URL? {
        switch self {
        case .listUsers:
            return URL(string: "https://api.github.com/users/")
        case .getUser(let username):
            return URL(string: "https://api.github.com/users/\(username)")
        case .avatar(let link):
            return URL(string: link)
        case .followers(let user):
            return URL(string: "https://api.github.com/users/\(user)/followers")
        case .usersFollowed(let user):
            return URL(string: "https://api.github.com/users/\(user)/following")
        }
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        switch self {
        case .avatar:
            break
        default:
            request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        }
        return request
    }
}
