//
//  MainTabBarItem.swift
//  TestTask
//

import SwiftUI

/// Represents the available items (tabs) in the custom main tab bar.
enum MainTabBarItem: String, CaseIterable {
    /// Tab that shows a list of users fetched from the API.
    case users = "Users"

    /// Tab that allows user registration via a POST request.
    case signUp = "Sign Up"

    /// The system image associated with each tab for display in the tab bar.
    var image: Image {
        switch self {
        case .users:
            // Symbol representing a group of users
            Image(systemName: "person.3.sequence.fill")
        case .signUp:
            // Symbol representing user addition
            Image(systemName: "person.crop.circle.fill.badge.plus")
        }
    }
}
