//
//  Buttons.swift
//  TestTask
//

import SwiftUI

/// A reusable button view that applies `CapsuleButtonStyle`.
struct Buttons: View {
    var body: some View {
        Button("Submit") {
            // Action for the button goes here
        }
        .buttonStyle(CapsuleButtonStyle())
        .typography(.body2)
        .fontWeight(.semibold)
    }
}

/// A capsule-shaped button style with pressed and disabled states.
struct CapsuleButtonStyle: ButtonStyle {
    // Track whether the button is enabled (automatically provided by SwiftUI)
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        // Determine background color based on button state
        let backgroundColor = !isEnabled ? Color.c_DEDEDE :                     // Disabled state
                              configuration.isPressed ? Color.c_primaryDark :   // Pressed state
                              Color.c_primary                                   // Default state

        // Determine text color based on enable state
        let foregroundColor: Color = isEnabled ? Color.c_black87 : Color.c_black48

        // Build the capsule-shaped button
        Capsule()
            .fill(backgroundColor)
            .frame(width: 140, height: 48)
            .overlay {
                configuration.label
                    .typography(.body2)
                    .fontWeight(.semibold)
                    .foregroundStyle(foregroundColor)
            }
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    Buttons()
}
