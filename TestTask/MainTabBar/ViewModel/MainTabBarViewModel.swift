//
//  BottomBarViewModel.swift
//  TestTask
//

import Foundation

class MainTabBarViewModel: ObservableObject {
    @Published var selectedTab: BottomTabBarItem = .users
}
