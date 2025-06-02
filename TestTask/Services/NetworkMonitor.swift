//
//  NetworkMonitor.swift
//  TestTask
//

import Foundation
import Network

/// Monitors the device’s network connectivity and optionally checks internet availability.
@MainActor
class NetworkMonitor: ObservableObject {
    // Publishes the current network connection status.
    @Published var isConnected: Bool = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        // Observe network path changes in a background queue.
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                // Update the connection status on the main thread.
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        // Stop monitoring when the instance is deallocated.
        monitor.cancel()
    }

    /// Performs an actual internet request to check access to the network.
    /// This is more reliable than checking NWPath status alone.
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

    /// Retry the internet check manually (e.g. when user taps "Try Again").
    func retry() async {
        let online = await checkInternetAccess()
        if online {
            self.isConnected = true
        }
    }
}
