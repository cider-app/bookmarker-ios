//
//  CustomButtonStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/29/20.
//

import SwiftUI

struct CustomButtonStyle : ButtonStyle {
    enum ButtonVariant {
        case text, contained
    }
    
    enum ButtonColor {
        case none, primary, secondary
    }
    
    var variant: ButtonVariant = .text
    var color: ButtonColor = .none
    var fullWidth: Bool = false
    
    func getButtonColor() -> Color {
        switch color {
        case .none:
            return Color.clear
        case .primary:
            return Color.primaryColor
        case .secondary:
            return Color(.systemGray6)
        }
    }
    
    func getTextColor() -> Color {
        switch color {
        case .none:
            return Color.primary
        case .primary:
            return Color.white
        case .secondary:
            return Color(.systemGray)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.system(.title3).weight(Constants.fontWeight))
            .padding()
            .frame(maxWidth: fullWidth ? .infinity : nil, alignment: .center)
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .fill(getButtonColor())
            )
            .foregroundColor(getTextColor())
            .saturation(configuration.isPressed ? Constants.buttonPressedSaturation : 1)
    }
}
