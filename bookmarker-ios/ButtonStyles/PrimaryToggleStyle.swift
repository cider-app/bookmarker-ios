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
            Spacer()
            Button(action: {
                configuration.isOn.toggle()
            }) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(configuration.isOn ? Color.primaryColor : Color(.systemGray5))
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(Color.white)
                            .padding(2)
                            .offset(x: configuration.isOn ? 10 : -10, y: 0)
                    )
                    .animation(Animation.linear(duration: 0.1))
            }
        }
    }
}
