//
//  UsersView.swift
//  TestTask
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var vm: UsersViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if vm.isLoading && !vm.didLoadOnce {
                ProgressView()
                    .tint(.gray)

            // Show content once loading completed at least once
            } else if vm.didLoadOnce {
                // If no users were fetched, show empty state view
                if vm.users.isEmpty {
                    UsersEmptyView()
                } else {
                    // Display list of user cards
                    List {
                        ForEach(vm.users) { user in
                            UserCardView(user: user, isLast: user == vm.users.last)
                                .background(Color.white)
                                // Load more users when the last one appears
                                .task {
                                    if user == vm.users.last && vm.hasMorePages && !vm.isLoading {
                                        await vm.loadUsers()
                                    }
                                }
                                // Remove row separators and apply padding
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
                        }
                        .background(Color.white)

                        // Show loading spinner at the bottom if more pages are available
                        if vm.isLoading && vm.hasMorePages {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .tint(.gray)
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .environment(\.colorScheme, .light)
                }
            }
        }
    }
}
