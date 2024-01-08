//
//  SearchView.swift
//  GIthub Finder
//
//  Created by UserTest on 03/01/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            Text("Searching for \(searchText)")
                .navigationTitle("Search a Github User")
        }
        .frame(height: 180)
        .offset(y: -280)
        .searchable(text: $searchText, prompt: "github_user")
        .onSubmit(of: .search, fetchUser)
    }
}

// MARK: Network request handling
extension SearchView {
    private func fetchUser() {
        print("searching ", searchText)
        Endpoint.getUser(searchText.lowercased()).request(completion: completionHandler)
    }

    private func completionHandler(_ apiResponse: APIResponse) {
        switch apiResponse {
        case .success(let data):
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
                let user = try Global.jsonDecoder.decode(GithubUser.self, from: data)
                print(user.username)
            } catch {
                print(error)
            }
        case .failure(let error):
            errorHandler(error)
        }
    }

    private func errorHandler(_ error: APIError) {
        switch error {
        case .requestCreationFailed:
            print("requestCreationFailed")
        case .requestFailed(let error):
            print("requestFailed:", error.localizedDescription)
        case .invalidResponseCode(let responseCode):
            print("invalidResponseCode:", responseCode)
        case .emptyResponseData:
            print("emptyResponseData")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
