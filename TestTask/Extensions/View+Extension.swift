//
//  View+Extension.swift
//  TestTask
//

import SwiftUI

extension View {
    func typography(_ style: TypographyStyle) -> some View {
        self.modifier(TypographyModifier(style: style))
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
