//
//  SecondaryButtonStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/27/20.
//

import SwiftUI

struct SecondaryButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(Font.system(.title3).weight(Constants.fontWeight))
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .fill(Color(.systemGray6))
            )
            .foregroundColor(Color(.systemGray))
            .saturation(configuration.isPressed ? Constants.buttonPressedSaturation : 1)
    }
}
