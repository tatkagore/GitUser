//
//  Model.swift
//  GitHubUsers
//
//  Created by Tatiana Simmer on 27/09/2022.
//

import Foundation
struct User: Identifiable, Decodable {
    let login: String
    let id: Int
    let repositories: Int
    let avatarUrl: String
    
    enum CodingKeys:  String, CodingKey {
        case login
        case id
        case repositories = "public_repos"
        case avatarUrl = "avatar_url"
    }
}

func getRandomUser(username: String) async throws -> User {
    guard let url = URL(string:
                "https://api.github.com/users/\(username)")
    else {
        fatalError("Missing URL")
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    let (data, response) = try await
        URLSession.shared.data(for: urlRequest)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200
    else {
        fatalError("Error while fetching data")
    }
    
    let decoded = try JSONDecoder().decode(User.self, from: data)
    return decoded
}
