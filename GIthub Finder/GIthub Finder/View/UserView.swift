//
//  UserView.swift
//  GIthub Finder
//
//  Created by UserTest on 04/01/24.
//

import SwiftUI

struct UserView: View {
    var user: GithubUser
    
    init(user: GithubUser) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.avatarUrl), scale: 1.5)
                .clipShape(Circle())
            Text(user.name ?? "")
                .font(.title)
            Text(user.description)
        }.offset(y: 20)
        
        VStack {
            UserDetailsView(detail: "Username: ", value: user.username)
            UserDetailsView(detail: "Followers:", value: String(user.followersCount))
            UserDetailsView(detail: "Following:", value: String(user.followingCount))
        }.offset(y: 30)
    }
}

// MARK: Network request handling
extension UserView {
    private mutating func fetchFollowers() {
        Endpoint.followers(ofUser: user.username).request(completion: completionHandler)
    }
    
    private mutating func fetchFollowing() {
        Endpoint.usersFollowed(byUser: user.username).request(completion: completionHandler)
    }
    
    private func completionHandler(_ response: APIResponse) {
        switch response {
        case .success(let data):
            do {
                let linkedUsers = try Global.jsonDecoder.decode([LinkedUser].self, from: data)
            } catch {
                print(error)
            }
        case .failure(let error):
            errorHandler(error: error)
        }
    }
    
    private func errorHandler(error: APIError) {
        switch error {
        case .requestCreationFailed:
            print("requestCreationFailed")
        case .requestFailed(let error):
            print("requestFailed:", error.localizedDescription)
        case .invalidResponseCode(let responseCode):
            print("invalidResponseCode:", responseCode)
        case .emptyResponseData:
            print("emptyResponseData")
        }
    }
}
