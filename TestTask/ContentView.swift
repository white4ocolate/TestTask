//
//  ContentView.swift
//  TestTask
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some View {
        if networkMonitor.isConnected {
            MainView()
        } else {
            NoConnectionView(networkMonitor: networkMonitor) {
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
