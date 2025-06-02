//
//  UsersView.swift
//  TestTask
//

import SwiftUI

struct UsersView: View {
    @StateObject private var vm = UsersViewModel()

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if vm.isLoading && !vm.didLoadOnce {
                ProgressView()
                    .tint(.gray)
            } else if vm.didLoadOnce {
                if vm.users.isEmpty {
                    UsersEmptyView()
                } else {
                    List {
                        ForEach(vm.users) { user in
                            UserCardView(user: user, isLast: user == vm.users.last)
                                .background(Color.white)
                                .onAppear {
                                    if user == vm.users.last && vm.hasMorePages && !vm.isLoading {
                                        Task {
                                            await vm.loadUsers()
                                        }
                                    }
                                }
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
                        }
                        .background(Color.white)
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

#Preview {
    UsersView()
}
