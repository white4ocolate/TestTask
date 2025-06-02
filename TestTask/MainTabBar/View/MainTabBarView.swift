//
//  MainTabBarView.swift
//  TestTask
//

import SwiftUI

struct MainTabBarView: View {
    @StateObject var bottomTabBarVM = MainTabBarViewModel()

    var body: some View {
        ZStack {
            Color.c_background.ignoresSafeArea()

            switch bottomTabBarVM.selectedTab {
            case .users:
                UsersView()
            case .signUp:
                SignUpView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            BottomTabBarView(selectedTab: $bottomTabBarVM.selectedTab)
        }
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
