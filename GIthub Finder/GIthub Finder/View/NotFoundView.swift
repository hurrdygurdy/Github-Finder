//
//  NotFoundView.swift
//  GIthub Finder
//
//  Created by UserTest on 08/01/24.
//

import SwiftUI

struct NotFoundView: View {
    let error: APIError
    var body: some View {
        VStack {
            Image("not-found").resizable().frame(width: 150.0, height: 150.0)
            Text(error.info).bold()
        }
    }
}
