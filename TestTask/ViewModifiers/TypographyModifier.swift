//
//  TypographyModifier.swift
//  TestTask
//

import SwiftUI

struct TypographyModifier: ViewModifier {
    let style: TypographyStyle

    func body(content: Content) -> some View {
        let lineSpacing = style.lineHeight - style.fontSize
        content
            .font(style.font)
            .lineSpacing(lineSpacing)
            .padding(.vertical, lineSpacing / 2)
    }
}
