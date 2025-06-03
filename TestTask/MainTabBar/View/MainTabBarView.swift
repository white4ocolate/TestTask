//
//  MainTabBarView.swift
//  TestTask
//

import SwiftUI

/// A container view that manages the layout and navigation between main app sections using a custom tab bar.
struct MainTabBarView: View {
    /// The view model holding the currently selected tab.
    @StateObject var bottomTabBarVM = MainTabBarViewModel()
    @EnvironmentObject var usersVM: UsersViewModel

    var body: some View {
        ZStack {
            Color.c_background.ignoresSafeArea()

            // Render corresponding content view based on selected tab.
            switch bottomTabBarVM.selectedTab {
            case .users:
                UsersView()
                    .environmentObject(usersVM)
            case .signUp:
                SignUpView()
            }
        }
        .onChange(of: bottomTabBarVM.selectedTab) {
            if bottomTabBarVM.selectedTab == .users {
                Task {
                    await usersVM.refreshUsers()
                }
            }
        }
        // Inject custom bottom tab bar.
        .safeAreaInset(edge: .bottom) {
            BottomTabBarView(selectedTab: $bottomTabBarVM.selectedTab)
        }
        // Inject dynamic top bar depending on selected tab.
        .safeAreaInset(edge: .top) {
            switch bottomTabBarVM.selectedTab {
            case .users:
                TopBarView(title: "Working with GET request")
            case .signUp:
                TopBarView(title: "Working with POST request")
            }
        }
    }
}

#Preview {
    MainTabBarView()
}
