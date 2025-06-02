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

    init() {
        Task {
            await loadUsers()
        }
    }

    @MainActor
    func loadUsers() async {
        guard !isLoading, hasMorePages else { return }
        isLoading = true

        let urlString = "https://frontend-test-assignment-api.abz.agency/api/v1/users?page=\(currentPage)&count=\(count)"
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode(UsersResponse.self, from: data),
               decodedData.success,
               let newUsers = decodedData.users {
                await MainActor.run {
                    self.users.append(contentsOf: newUsers)
                    self.currentPage += 1
                    self.hasMorePages = self.currentPage <= decodedData.total_pages
                }
            }
        } catch {
            print("Error:", error.localizedDescription)
        }
        await MainActor.run {
            self.isLoading = false
            self.didLoadOnce = true
        }
    }
}
