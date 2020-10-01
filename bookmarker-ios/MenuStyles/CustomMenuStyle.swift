//
//  CustomMenuStyle.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import SwiftUI

struct CustomMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: Constants.cornerRadius,
                    style: .continuous
                )
                .fill(Color(.systemGray6))
            )
    }
}
