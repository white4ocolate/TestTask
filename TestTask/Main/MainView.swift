//
//  MainView.swift
//  TestTask
//

import SwiftUI

struct MainView: View {
    @StateObject private var router = Router.shared

    var body: some View {
        ZStack {
            NavigationStack(path: $router.path) {
                EmptyView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .mainTabBar:
                            MainTabBarView()
                                .navigationBarBackButtonHidden()
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            Task {
                await router.startApp()
            }
        }
    }
}

#Preview {
    MainView()
}
