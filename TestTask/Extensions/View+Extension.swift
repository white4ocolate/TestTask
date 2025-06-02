//
//  View+Extension.swift
//  TestTask
//

import SwiftUI

extension View {
    /// Applies a custom typography style to the view using a predefined `TypographyStyle`.
    ///
    /// This helps maintain consistent font sizes, weights, and line heights across the app.
    ///
    /// - Parameter style: The typography style to apply (e.g., `.heading1`, `.bodySmall`, etc.)
    /// - Returns: A view with the specified typography style applied.
    func typography(_ style: TypographyStyle) -> some View {
        self.modifier(TypographyModifier(style: style))
    }

    /// Hides the software keyboard by resigning the first responder status.
    ///
    /// Can be called on any view (e.g., inside a `TapGesture`) to dismiss the keyboard.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
