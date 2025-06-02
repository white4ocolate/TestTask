//
//  Colors.swift
//  TestTask
//

import SwiftUI

/// Centralized extension for accessing app-specific color assets.
/// This improves code readability and enforces a consistent design system across the app.
extension Color {
    static let c_primary = Color("CustomPrimary")
    static let c_secondary = Color("CustomSecondary")
    static let c_secondaryDark = Color("CustomSecondaryDark")
    static let c_background = Color("CustomBackground")
    static let c_black = Color("CustomBlack")
    static let c_primaryDark = Color("CustomPrimaryDark")
    static let s_primary = Color("SchemesPrimary")
    static let c_DEDEDE = Color("DEDEDE")
    static let c_F8F8F8 = Color("F8F8F8")
    static let c_black87 = Color("CustomBlack").opacity(0.87)
    static let c_black48 = Color("CustomBlack").opacity(0.47)
    static let c_black60 = Color("CustomBlack").opacity(0.6)
    static let c_Error = Color("CustomError")
    static let c_D0CFCF = Color("D0CFCF")
}
