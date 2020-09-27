//
//  ColorGridPickerView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/23/20.
//

import SwiftUI

struct ColorGridPickerView: View {
    @StateObject var vm = ColorPickerViewModel()
    
    var colors = [
        Color.Color020887,
        Color.ColorA71D31,
        Color.Color4B8F8C,
        Color.Color9A7AA0
    ]
    
    let rows = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(colors, id: \.self) { color in
                    ColorGridCellView(color: color)
                }
            }
            .padding(.leading)
        }
    }
}

struct ColorGridPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorGridPickerView()
    }
}
