//
//  UsersEmptyView.swift
//  TestTask
//

import SwiftUI

/// A view that is shown when the user list is empty
struct UsersEmptyView: View {
    var body: some View {
        VStack(spacing: 24) {
            // Placeholder image for the empty state
            Image(.usersCircle)
                .resizable()
                .frame(width: 201, height: 200)
                .aspectRatio(contentMode: .fill)
            
            // Informational text
            Text("There are no users yet")
                .typography(.heading1)
                .foregroundStyle(Color.c_black87)
        }
    }
}

#Preview {
    UsersEmptyView()
}
