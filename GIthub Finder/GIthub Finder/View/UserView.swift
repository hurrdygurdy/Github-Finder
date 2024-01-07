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
