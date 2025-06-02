//
//  TypographyStyle.swift
//  TestTask
//

import SwiftUI

/// A design system enum representing different text styles used across the app.
/// Provides consistent font, line height, and font size values per style.
enum TypographyStyle {
    case heading1
    case bodySmall
    case body1
    case body2
    case body3

    /// The font used for each text style.
    /// All styles use the "Nunito Sans" font with different sizes.
    var font: Font {
        switch self {
        case .heading1: return .custom("Nunito Sans", size: 20)
        case .bodySmall: return .custom("Nunito Sans", size: 12)
        case .body1: return .custom("Nunito Sans", size: 16)
        case .body2: return .custom("Nunito Sans", size: 18)
        case .body3: return .custom("Nunito Sans", size: 14)
        }
    }

    /// The line height (leading) associated with each text style.
    /// Used for vertical spacing and better visual rhythm.
    var lineHeight: CGFloat {
        switch self {
        case .bodySmall: return 16
        case .heading1, .body1, .body2: return 24
        case .body3: return 20
        }
    }

    /// The font size for each text style, exposed separately for layout calculations if needed.
    var fontSize: CGFloat {
        switch self {
        case .heading1: return 20
        case .bodySmall: return 12
        case .body1: return 16
        case .body2: return 18
        case .body3: return 14
        }
    }
}
