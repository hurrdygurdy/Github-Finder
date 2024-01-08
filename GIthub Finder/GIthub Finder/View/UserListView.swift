//
//  UserListView.swift
//  GIthub Finder
//
//  Created by UserTest on 07/01/24.
//

import SwiftUI

struct UserListView: View {
    let list: [LinkedUser]
    
    var body: some View {
        List(list, id: \.username) { user in
            UserListItem(user: user)
        }
    }
}
