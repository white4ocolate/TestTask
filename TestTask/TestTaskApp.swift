//
//  TestTaskApp.swift
//  TestTask
//

import SwiftUI

@main
struct TestTaskApp: App {
    @State private var isActive = false
    @StateObject var usersVM = UsersViewModel()

    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
                    .environmentObject(usersVM)
            } else {
                SplashScreenView()
                    .task {
                        do {
                            try await withThrowingTaskGroup(of: Void.self) { group in
                                group.addTask {
                                    await usersVM.loadUsers()
                                }
                                group.addTask {
                                    try await Task.sleep(nanoseconds: 2_000_000_000)
                                }
                                try await group.waitForAll()
                            }
                            isActive = true
                        } catch {
                            print("Error loading users:", error)
                        }
                    }
            }
        }
    }
}
