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
            Text(user.name ?? "")
            Text(user.description)
            Text("username: \(user.username)")
        }
    }
}
