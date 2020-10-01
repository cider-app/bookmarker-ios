//
//  PrimaryButtonStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(Font.system(.title3).weight(Constants.fontWeight))
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .fill(Color.primaryColor)
            )
            .foregroundColor(Color.white)
            .saturation(configuration.isPressed ? Constants.buttonPressedSaturation : 1)
    }
}
