//
//  Router.swift
//  TestTask
//

import Foundation

final class Router: ObservableObject {
    static let shared = Router()
    @Published var path = [Route]()
}

extension Router {
    func startApp() async {
        await MainActor.run {
            path.removeAll()
            path.append(.mainTabBar)
        }
    }

    func replace(with item: Route) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(item)
    }
}
