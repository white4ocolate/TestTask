//
//  TextFieldState.swift
//  TestTask
//

import SwiftUI

// Represents the different visual states of a custom text field
enum TextFieldState {
    case enabled
    case enabledFilled
    case focused
    case focusedFilled
    case error
    case errorFilled

    // Returns the appropriate border color based on the current state
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

    // Returns the appropriate placeholder text color based on the current state
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
