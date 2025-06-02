//
//  ContentView.swift
//  TestTask
//

import SwiftUI

struct ContentView: View {
    // Network monitor to observe the internet connection status
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some View {
        // Show main content when connected, or a "no connection" screen otherwise
        if networkMonitor.isConnected {
            MainView()
        } else {
            NoConnectionView(networkMonitor: networkMonitor) {
                // Retry the connection when the user taps "Try again"
                Task {
                    await networkMonitor.retry()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
