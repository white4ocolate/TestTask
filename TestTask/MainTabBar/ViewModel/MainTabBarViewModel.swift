//
//  BottomBarViewModel.swift
//  TestTask
//

import Foundation


/// ViewModel for managing the state of the main tab bar.
class MainTabBarViewModel: ObservableObject {
    /// The currently selected tab in the users tab.
    @Published var selectedTab: MainTabBarItem = .users
}
