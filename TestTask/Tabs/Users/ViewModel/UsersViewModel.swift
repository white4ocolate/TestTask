//
//  UsersViewModel.swift
//  TestTask
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var currentPage = 1
    @Published var isLoading = false
    @Published var hasMorePages = true
    @Published var didLoadOnce = false

    private let count = 6

    @MainActor
    func loadUsers() async {
        print("loadUsers")
        // Prevent duplicate loading and stop if no more pages
        guard !isLoading, hasMorePages else { return }
        isLoading = true

        do {
            let response = try await UserService.fetchUsers(page: currentPage, count: count)

            if let decodedData = response, decodedData.success, let newUsers = decodedData.users {
                await MainActor.run {
                    self.users.append(contentsOf: newUsers)
                    self.currentPage += 1

                    // Check if there are more pages to load
                    self.hasMorePages = self.currentPage <= decodedData.total_pages
                }
            }
        } catch {
            print("Error:", error.localizedDescription)
        }
        await MainActor.run {
            // Mark loading as finished
            self.isLoading = false
            self.didLoadOnce = true
        }
    }

    @MainActor
    func refreshUsers() async {
        guard !isLoading else { return }

        // refresh current users
        users = []
        currentPage = 1
        hasMorePages = true
        didLoadOnce = false

        await loadUsers()
    }
}
