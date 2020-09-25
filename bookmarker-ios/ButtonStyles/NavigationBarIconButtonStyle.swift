//
//  NavigationBarIconButtonStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//

import SwiftUI

struct NavigationBarIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
            .foregroundColor(Color.primary)
    }
}
