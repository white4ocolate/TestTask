//
//  UsersEmptyView.swift
//  TestTask
//

import SwiftUI

struct UsersEmptyView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(.usersCircle)
                .resizable()
                .frame(width: 201, height: 200)
                .aspectRatio(contentMode: .fill)
            Text("There are no users yet")
                .typography(.heading1)
                .foregroundStyle(Color.c_black87)
        }
    }
}

#Preview {
    UsersEmptyView()
}
