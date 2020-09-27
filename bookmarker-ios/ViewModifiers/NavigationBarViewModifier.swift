//
//  NavigationBarViewModifier.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/27/20.
//

import SwiftUI

struct NavigationBarViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom, 8)
    }
}
