//
//  UserView.swift
//  GIthub Finder
//
//  Created by UserTest on 04/01/24.
//

import SwiftUI

struct UserView: View {
    var user: GithubUser
    @State private var showLinkedUser: Bool = false
    @State private var linkedUsers: [LinkedUser] = []
    
    init(user: GithubUser) {
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: user.avatarUrl), scale: 1.5)
                    .clipShape(Circle())
                Text(user.name ?? "")
                    .font(.title)
                Text(user.description ?? "")
            }.offset(y: 20)
            
            VStack {
                UserDetailsView(detail: "Username: ", value: user.username)
                UserDetailsView(detail: "Followers:", value: String(user.followersCount)).onTapGesture {
                    Endpoint.followers(ofUser: user.username).request(completion: completionHandler)
                }
                UserDetailsView(detail: "Following:", value: String(user.followingCount)).onTapGesture {
                    Endpoint.usersFollowed(byUser: user.username).request(completion: completionHandler)
                }
            }.offset(y: 30)
        }.navigationDestination(isPresented: $showLinkedUser) {
            UserListView(list: linkedUsers)
        }
    }
}

extension UserView: RequestParser {
    var decodable: Decodable.Type {
        return [LinkedUser].self
    }
    
    func fetchDidCompleteWith(result: Decodable) {
        DispatchQueue.main.async {
            guard let linkedUsers = result as? [LinkedUser] else {
                return
            }
            self.linkedUsers = linkedUsers
            self.showLinkedUser = true
        }
    }
    
    func fetchFailedWith(error: Error) {
        print(error)
    }
}
