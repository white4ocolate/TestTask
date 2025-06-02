//
//  Buttons.swift
//  TestTask
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        Button("Normal") {
            //
        }
        .buttonStyle(CapsuleButtonStyle())
        .typography(.body2)
        .fontWeight(.semibold)
    }
}

struct CapsuleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = !isEnabled ? Color.c_DEDEDE :
                              configuration.isPressed ? Color.c_primaryDark :
                              Color.c_primary
        let foregroundColor: Color = isEnabled ? Color.c_black87 : Color.c_black48

        Capsule()
            .fill(backgroundColor)
            .frame(width: 140, height: 48)
            .overlay {
                configuration.label
                    .typography(.body2)
                    .fontWeight(.semibold)
                    .foregroundStyle(foregroundColor)
            }
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    Buttons()
}
