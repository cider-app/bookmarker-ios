//
//  TextFieldViewModifier.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    enum Variant {
        case outlined, filled
    }
    
    var variant: Variant = .outlined
    
    func body(content: Content) -> some View {
        content
            .font(Font.system(.body).weight(Constants.fontWeight))
            .padding()
            .overlay(variant == Variant.outlined ?
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).stroke(Color(.systemGray6), lineWidth: 2)
                : nil
            )
            .background(variant == Variant.filled ?
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color(.systemGray6))
                : nil
            )
    }
}
