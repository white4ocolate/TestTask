//
//  NoConnectionView.swift
//  TestTask
//

import SwiftUI

struct NoConnectionView: View {
    @ObservedObject var networkMonitor: NetworkMonitor
    var onRetrySuccess: () -> Void

    var body: some View {
        ZStack {
            Color.c_background.ignoresSafeArea()

            VStack(spacing: 24) {
                Image(.noInternet)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text("There is no internet connection")
                    .typography(.heading1)

                Button("Try again") {
                    onRetrySuccess()
                }
                .buttonStyle(CapsuleButtonStyle())
            }
        }
    }
}

#Preview {
    NoConnectionView(networkMonitor: NetworkMonitor(), onRetrySuccess: {})
}
