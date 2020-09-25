//
//  TextFieldViewModifier.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(.body).weight(Constants.fontWeight))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).stroke(Color(.systemGray6), lineWidth: 2))
    }
}
