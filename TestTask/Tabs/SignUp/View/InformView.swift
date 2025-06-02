//
//  InformView.swift
//  TestTask
//

import SwiftUI

struct InformView: View {
    @Environment(\.dismiss) var dismiss // Allows the view to dismiss itself
    @Binding var isSuccess: Bool        // Determines if the result was successful or not
    var message: String = "That email is already registered"    // Default error message

    var body: some View {
        ZStack {
            Color.c_background.ignoresSafeArea()
            VStack(spacing: 24) {
                // Display success or error image
                Image(isSuccess ? .success : .error)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

                // Show success message or custom error message
                Text(isSuccess ? "User successfully registered" : message)
                    .typography(.heading1)
                    .foregroundStyle(Color.c_black87)

                // Button to dismiss view
                Button(isSuccess ? "Got it" : "Try again") {
                    dismiss()
                }
                .buttonStyle(CapsuleButtonStyle())
            }
        }
        .frame(maxHeight: .infinity)

        // Top close button inset into safe area
        .safeAreaInset(edge: .top) {
            HStack {
                Spacer()
                Image(.close)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    InformView(isSuccess: .constant(true))
}
