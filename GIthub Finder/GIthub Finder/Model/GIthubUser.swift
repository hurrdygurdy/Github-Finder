//
//  GIthubUser.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import Foundation

struct GithubUser: Decodable {
    let username: String
    /// Display name
    let name: String?
    let avatarUrl: String
    /// Bio
    let description: String
    let followersCount: Int
    let followingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case name
        case avatarUrl = "avatar_url"
        case description = "bio"
        case followersCount = "followers"
        case followingCount = "following"
    }
}
