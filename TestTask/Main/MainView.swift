//
//  MainView.swift
//  TestTask
//

import SwiftUI

/// Root view of the app that manages global navigation using a shared Router.
struct MainView: View {
    // Shared router instance used to control navigation throughout the app.
    @StateObject private var router = Router.shared

    var body: some View {
        ZStack {
            // Root navigation stack bound to the router's navigation path.
            NavigationStack(path: $router.path) {
                // EmptyView is used as a placeholder, real content is injected via navigationDestination.
                EmptyView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .mainTabBar:
                            // Entry point into the main tab bar UI
                            MainTabBarView()
                                .navigationBarBackButtonHidden()    // Hide default back button for root screens
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            // Start the app flow by navigating to the initial screen
            await router.startApp()
        }

    }
}

#Preview {
    MainView()
}
