//
//  BottomBarView.swift
//  TestTask
//

import SwiftUI

/// A custom bottom tab bar with multiple tab items.
struct BottomTabBarView: View {
    // Currently selected tab (binds to external state)
    @Binding var selectedTab: MainTabBarItem

    // All available tab bar items (defaults to all cases of MainTabBarItem enum)
    var tabBarItems: [MainTabBarItem] = MainTabBarItem.allCases

    var body: some View {
        HStack {
            // Render each tab using the helper function
            ForEach(tabBarItems, id:\.self) { item in
                showTab(tab: item)
            }
        }
        .frame(height: 56)
        .background(Color.c_F8F8F8)
    }
}

extension BottomTabBarView {
    /// Renders a single tab item with icon and text.
    func showTab(tab: MainTabBarItem) -> some View {
        HStack(spacing: 8) {
            tab.image
                .resizable()
                .scaledToFit()
                .frame(height: 17)
            Text(tab.rawValue)
                .typography(.body1)
        }
        .foregroundStyle(selectedTab == tab ? Color.c_secondary : Color.c_black)    // Change color depending on selection
        .onTapGesture {
            selectedTab = tab
        }

        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BottomTabBarView(selectedTab: .constant(.users))
}
