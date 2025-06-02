//
//  TypographyModifier.swift
//  TestTask
//

import SwiftUI

/// A custom view modifier that applies typography styling based on the given `TypographyStyle`
struct TypographyModifier: ViewModifier {
    let style: TypographyStyle

    func body(content: Content) -> some View {
        // Calculate additional spacing to achieve the desired line height
        let lineSpacing = style.lineHeight - style.fontSize
        content
            .font(style.font)                       // Apply custom font
            .lineSpacing(lineSpacing)               // Apply line spacing for consistent text layout
            .padding(.vertical, lineSpacing / 2)    // Add vertical padding to balance the spacing visually
    }
}
