//
//  UserListItem.swift
//  GIthub Finder
//
//  Created by UserTest on 07/01/24.
//

import SwiftUI

struct UserListItem: View {
    let user: LinkedUser
    @State private var githubUser: GithubUser?
    @State private var showUserView: Bool = false
    @State private var error: APIError = .emptyResponseData
    
    var body: some View {
        NavigationStack {
            HStack {
                AsyncImage(url: URL(string: user.avatarUrl), content: { image in
                    image.setImage(maxWidth: 50.0, maxHeight: 50.0)
                }, placeholder: {
                    Image("user").setImage(maxWidth: 50.0, maxHeight: 50.0)
                }).clipShape(Circle())
                Text(user.username).padding(20.0).bold()
            }
            .navigationDestination(isPresented: $showUserView) {
                if githubUser == nil {
                    NotFoundView(error: error)
                } else {
                    UserView(user: githubUser!)
                }
            }.onTapGesture {
                Endpoint.getUser(user.username).request(completion: completionHandler)
            }
        }
    }
}

extension UserListItem: RequestParser {
    var decodable: Decodable.Type {
        return GithubUser.self
    }
    
    func fetchDidCompleteWith(result: Decodable) {
        DispatchQueue.main.async {
            guard let githubUser = result as? GithubUser else {
                return
            }
            self.githubUser = githubUser
            self.showUserView = true
        }
    }
    
    func fetchFailedWith(error: APIError) {
        print(error)
        self.showUserView = true
        self.error = error
    }
}
