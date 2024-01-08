//
//  SearchView.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var user: GithubUser?
    @State private var showUserView: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Searching for \(searchText)")
                .navigationTitle("Search a Github User")
                .navigationDestination(isPresented: $showUserView) {
                    if user == nil {
                        EmptyView()
                    } else {
                        UserView(user: user!)
                    }
                }
        }
        .searchable(text: $searchText, prompt: "github_user")
        .onSubmit(of: .search, searchUser)
    }
    
    func searchUser() {
        Endpoint.getUser(searchText).request(completion: completionHandler)
    }
}

// MARK: Network request handling
extension SearchView: RequestParser {
    var decodable: Decodable.Type {
        return GithubUser.self
    }
    
    func fetchDidCompleteWith(result: Decodable) {
        DispatchQueue.main.async {
            guard let githubUser = result as? GithubUser else {
                return
            }
            self.user = githubUser
            self.showUserView = true
        }
    }
    
    func fetchFailedWith(error: Error) {
        print(error)
    }
}
