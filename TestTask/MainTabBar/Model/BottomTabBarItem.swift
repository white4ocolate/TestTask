//
//  BottomTabBarItem.swift
//  TestTask
//

import SwiftUI

enum BottomTabBarItem: String, CaseIterable {
    case users = "Users"
    case signUp = "Sign Up"

    var image: Image {
        switch self {
        case .users:
            Image(systemName: "person.3.sequence.fill")
        case .signUp:
            Image(systemName: "person.crop.circle.fill.badge.plus")
        }
    }
}
