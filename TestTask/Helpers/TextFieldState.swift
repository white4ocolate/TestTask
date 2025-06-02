//
//  TextFieldState.swift
//  TestTask
//

import SwiftUI

enum TextFieldState {
    case enabled
    case enabledFilled
    case focused
    case focusedFilled
    case error
    case errorFilled

    var borderColor: Color {
        switch self {
        case .enabled, .enabledFilled:
            Color.c_D0CFCF
        case .focused, .focusedFilled:
            Color.c_secondary
        case .error, .errorFilled:
            Color.c_Error
        }
    }

    var placeHolderColor: Color {
        switch self {
        case .enabled:
            Color.c_black48
        case .enabledFilled:
            Color.c_black60
        case .focused:
            Color.c_secondary
        case .focusedFilled:
            Color.s_primary
        case .error, .errorFilled:
            Color.c_Error
        }
    }
}
