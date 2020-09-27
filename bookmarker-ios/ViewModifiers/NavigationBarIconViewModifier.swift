//
//  NavigationBarIconViewModifier.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/27/20.
//

import SwiftUI

struct NavigationBarIconViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
            .foregroundColor(Color.primary)
    }
}
