//
//  NoConnectionView.swift
//  TestTask
//

import SwiftUI

/// A view that displays a no-internet-connection screen with a retry button.
struct NoConnectionView: View {
    /// Observable network monitor used to check connectivity status.
    @ObservedObject var networkMonitor: NetworkMonitor

    /// Called when retry attempt detects an active internet connection.
    var onRetrySuccess: () -> Void

    var body: some View {
        ZStack {
            Color.c_background.ignoresSafeArea()

            VStack(spacing: 24) {
                // Informative illustration representing no internet connectivity.
                Image(.noInternet)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

                // Main message to the user.
                Text("There is no internet connection")
                    .typography(.heading1)

                // Retry button to re-attempt the network check.
                Button("Try again") {
                    onRetrySuccess()
                }
                .buttonStyle(CapsuleButtonStyle())  // Custom button style
            }
        }
    }
}

#Preview {
    NoConnectionView(networkMonitor: NetworkMonitor(), onRetrySuccess: {})
}
