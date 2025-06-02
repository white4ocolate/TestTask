//
//  TypographyStyle.swift
//  TestTask
//

import SwiftUI

enum TypographyStyle {
    case heading1
    case bodySmall
    case body1
    case body2
    case body3

    var font: Font {
        switch self {
        case .heading1: return .custom("Nunito Sans", size: 20)
        case .bodySmall: return .custom("Nunito Sans", size: 12)
        case .body1: return .custom("Nunito Sans", size: 16)
        case .body2: return .custom("Nunito Sans", size: 18)
        case .body3: return .custom("Nunito Sans", size: 14)
        }
    }

    var lineHeight: CGFloat {
        switch self {
        case .bodySmall: return 16
        case .heading1, .body1, .body2: return 24
        case .body3: return 20
        }
    }

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
