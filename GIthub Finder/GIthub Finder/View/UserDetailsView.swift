//
//  UserDetailsView.swift
//  GIthub Finder
//
//  Created by UserTest on 07/01/24.
//

import SwiftUI
/// Sub details of an user
struct UserDetailsView: View {
    
    let detail: String
    let value: String
    
    init(detail: String, value: String) {
        self.detail = detail
        self.value = value
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(detail)
                    .bold()
                Spacer()
                Text(value)
            }
        }.padding(5.0).frame(width: 300.0)
    }
}
