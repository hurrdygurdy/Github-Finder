//
//  UserListView.swift
//  GIthub Finder
//
//  Created by UserTest on 07/01/24.
//

import SwiftUI

struct UserListView: View {
    var list: [LinkedUser]
    
    var body: some View {
        List(list.sorted { lhs, rhs in lhs.username.lowercased() < rhs.username.lowercased() }, id: \.username) { user in
            UserListItem(user: user)
        }
    }
}
