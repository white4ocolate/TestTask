//
//  UserService.swift
//  TestTask
//

import Foundation

struct UserService {

    /// Fetch users from the API for a given page and count
    static func fetchUsers(page: Int, count: Int) async throws -> UsersResponse? {
        // Construct the URL string with page and count parameters
        let urlString = "https://frontend-test-assignment-api.abz.agency/api/v1/users?page=\(page)&count=\(count)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        // Make an asynchronous request to fetch data from the API
        let (data, _) = try await URLSession.shared.data(from: url)

        // Try to decode the received JSON data into the UsersResponse model
        do {
            let decoded = try JSONDecoder().decode(UsersResponse.self, from: data)
            return decoded
        } catch {
            // Log and return nil if decoding fails
            print("Decoding error:", error)
            return nil
        }
    }
}
