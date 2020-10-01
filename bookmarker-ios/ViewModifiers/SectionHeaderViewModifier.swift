//
//  SectionHeaderViewModifier.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//


import SwiftUI

struct SectionHeaderViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textCase(.uppercase)
            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(.medium))
            .foregroundColor(Color(.tertiaryLabel))
            .padding(.top)
            .padding(.top)
    }
}
