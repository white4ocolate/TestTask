//
//  SplashScreenView.swift
//  TestTask
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.c_primary.ignoresSafeArea()

            VStack {
                Image(.logo)
                    .resizable()
                    .frame(width: 95.42, height: 65.09)
                    .aspectRatio(contentMode: .fit)
                Image(.logoText)
                    .resizable()
                    .frame(width: 160, height: 26.35)
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
