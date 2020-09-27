//
//  TextButtonStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/27/20.
//

import SwiftUI

struct TextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.system(.body).weight(Constants.fontWeight))
            .foregroundColor(Color.primaryColor)
            .saturation(configuration.isPressed ? Constants.buttonPressedSaturation : 1)
    }
}
