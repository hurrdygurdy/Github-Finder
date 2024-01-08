//
//  LinkedUser.swift
//  GIthub Finder
//
//  Created by UserTest on 07/01/24.
//

import Foundation
/// Details of a user followed/following by another user.
struct LinkedUser: Decodable {
    let username: String
    /// Display name
    let name: String?
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case name
        case avatarUrl = "avatar_url"
    }
}

enum LinkedUserType {
    case follower
    case following
    
    var title: String {
        switch self {
        case .follower: return "Follower"
        case .following: return "Following"
        }
    }
}
