//
//  PrimaryToggleStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//

import SwiftUI

struct PrimaryToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(Font.system(.headline).weight(.semibold))
            Spacer()
            Button(action: {
                configuration.isOn.toggle()
            }) {
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                    .fill(configuration.isOn ? Color.primaryColor : Color(.systemGray6))
                    .frame(width: 50, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                            .fill(Color.white)
                            .frame(width: 26, height: 26)
                            .padding(2)
                            .offset(x: configuration.isOn ? 10 : -10, y: 0)
                    )
                    .animation(Animation.linear(duration: 0.1))
            }
        }
    }
}
