//
//  UserCardView.swift
//  TestTask
//

import SwiftUI

/// A view that displays a user's profile card with avatar, name, position, email, and phone
struct UserCardView: View {
    var user: User
    var isLast: Bool    // Determines whether to show a divider under the card

    var body: some View {
        HStack(alignment:.top, spacing: 16) {
            // Load user photo from URL or show placeholder if loading
            AsyncImage(url: URL(string: user.photo)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
            }
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())    // Make image circular
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                // User name and position
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .typography(.body2)
                        .foregroundStyle(Color.c_black87)

                    Text(user.position)
                        .typography(.body3)
                        .foregroundStyle(Color.c_black60)
                }

                // User email and phone number
                VStack(alignment: .leading, spacing: 4) {
                    Text(AttributedString(user.email))
                        .typography(.body3)
                        .foregroundStyle(Color.c_black87)
                    Text(user.phone)
                        .typography(.body3)
                        .foregroundStyle(Color.c_black87)
                }
                .padding(.bottom, 24)

                // Add divider if this is not the last user
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
