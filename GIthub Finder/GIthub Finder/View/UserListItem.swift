//
//  UserListItem.swift
//  GIthub Finder
//
//  Created by UserTest on 07/01/24.
//

import SwiftUI

struct UserListItem: View {
    let user: LinkedUser
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl), scale: 3.0).clipShape(Circle())
            VStack {
                Text(user.name ?? "")
                Text(user.username)
                Spacer()
            }
        }
    }
}
