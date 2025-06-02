//
//  Router.swift
//  TestTask
//

import Foundation

/// A singleton responsible for managing navigation stack in the app.
final class Router: ObservableObject {
    // Shared instance of the router used across the app.
    static let shared = Router()

    // Current navigation path used by NavigationStack.
    @Published var path = [Route]()
}

extension Router {
    /// Starts the app by resetting the navigation stack and pushing the main tab bar.
    func startApp() async {
        await MainActor.run {
            path.removeAll()
            path.append(.mainTabBar)
        }
    }

    /// Replaces the last item in the navigation path with a new one.
    /// Useful for shallow navigation changes without pushing a new route.
    func replace(with item: Route) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(item)
    }
}
