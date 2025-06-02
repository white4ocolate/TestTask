//
//  BottomBarView.swift
//  TestTask
//

import SwiftUI

struct BottomTabBarView: View {
    @Binding var selectedTab: BottomTabBarItem
    var tabBarItems: [BottomTabBarItem] = BottomTabBarItem.allCases

    var body: some View {
        HStack {
            ForEach(tabBarItems, id:\.self) { item in
                showTab(tab: item)
            }
        }
        .frame(height: 56)
        .background(Color.c_F8F8F8)
    }
}

extension BottomTabBarView {
    func showTab(tab: BottomTabBarItem) -> some View {
        HStack(spacing: 8) {
            tab.image
                .resizable()
                .scaledToFit()
                .frame(height: 17)
            Text(tab.rawValue)
                .typography(.body1)
        }
        .foregroundStyle(selectedTab == tab ? Color.c_secondary : Color.c_black)
        .onTapGesture {
            selectedTab = tab
        }

        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BottomTabBarView(selectedTab: .constant(.users))
}
