//
//  UserCardView.swift
//  TestTask
//

import SwiftUI

struct UserCardView: View {
    var user: User
    var isLast: Bool
    var body: some View {
        HStack(alignment:.top, spacing: 16) {
            AsyncImage(url: URL(string: user.photo)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
            }
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .typography(.body2)
                        .foregroundStyle(Color.c_black87)

                    Text(user.position)
                        .typography(.body3)
                        .foregroundStyle(Color.c_black60)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(AttributedString(user.email))
                        .typography(.body3)
                        .foregroundStyle(Color.c_black87)
                    Text(user.phone)
                        .typography(.body3)
                        .foregroundStyle(Color.c_black87)
                }
                .padding(.bottom, 24)

                if !isLast {
                    Divider()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    UserCardView(user: User(id: 1, name: "Name user", email: "user@email.com", phone: "380663211234", position: "Developer", photo: "Photo1"), isLast: false)
}
