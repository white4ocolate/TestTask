//
//  InformView.swift
//  TestTask
//

import SwiftUI

struct InformView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isSuccess: Bool
    var message: String = "That email is already registered"

    var body: some View {
        ZStack {
            Color.c_background.ignoresSafeArea()
            VStack(spacing: 24) {
                Image(isSuccess ? .success : .error)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text(isSuccess ? "User successfully registered" : message)
                    .typography(.heading1)
                    .foregroundStyle(Color.c_black87)

                Button(isSuccess ? "Got it" : "Try again") {
                    dismiss()
                }
                .buttonStyle(CapsuleButtonStyle())
            }
        }
        .frame(maxHeight: .infinity)
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
