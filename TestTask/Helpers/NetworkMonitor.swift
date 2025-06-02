//
//  NetworkMonitor.swift
//  TestTask
//

import Foundation
import Network

@MainActor
class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }

    func checkInternetAccess() async -> Bool {
        guard let url = URL(string: "https://apple.com") else { return false }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return (response as? HTTPURLResponse)?.statusCode == 200
        } catch {
            return false
        }
    }

    func retry() async {
        let online = await checkInternetAccess()
        if online {
            self.isConnected = true
        }
    }
}
