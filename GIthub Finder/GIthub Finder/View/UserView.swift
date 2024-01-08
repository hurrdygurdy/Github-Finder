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
    @State private var error: APIError = .emptyResponseData
    
    init(user: GithubUser) {
        self.user = user
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: user.avatarUrl), content: { image in
                    image.setImage(maxWidth: 300.0, maxHeight: 300.0)
                }, placeholder: {
                    Image("user").setImage(maxWidth: 300.0, maxHeight: 300.0)
                }).clipShape(Circle())
                Text(user.name ?? "")
                    .font(.title)
                Text(user.description ?? "").padding(15.0)
            }.offset(y: -35)
            
            VStack {
                UserDetailsView(detail: "Username: ", value: user.username)
                UserDetailsView(detail: "Followers:", value: String(user.followersCount)).onTapGesture {
                    if user.followersCount == 0 {
                        print("No followers")
                    } else {
                        Endpoint.followers(ofUser: user.username).request(completion: completionHandler)
                    }
                }
                UserDetailsView(detail: "Following:", value: String(user.followingCount)).onTapGesture {
                    if user.followingCount == 0 {
                        print("No Following")
                    } else {
                        Endpoint.usersFollowed(byUser: user.username).request(completion: completionHandler)
                    }
                }
            }.offset(y: -20)
        }.navigationDestination(isPresented: $showLinkedUser) {
            if linkedUsers.isEmpty {
                NotFoundView(error: error)
            } else {
                UserListView(list: linkedUsers)
            }
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
    
    func fetchFailedWith(error: APIError) {
        print(error)
        self.showLinkedUser = true
        self.error = error
    }
}
