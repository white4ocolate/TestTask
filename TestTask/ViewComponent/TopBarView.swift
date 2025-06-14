//
//  TopBarView.swift
//  TestTask
//

import SwiftUI

/// A reusable top bar view with a centered title and primary background color
struct TopBarView: View {
    var title: String

    var body: some View {
        Text(title)
            .typography(.heading1)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.c_primary)
            .foregroundStyle(Color.c_black87)
    }
}

#Preview {
    TopBarView(title: "Working with GET request")
}
