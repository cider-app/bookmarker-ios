//
//  NavigationTitleViewModifier.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/29/20.
//

import SwiftUI

struct NavigationTitleViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(.title3).weight(Constants.fontWeight))
            .foregroundColor(Color.primary)
    }
}
