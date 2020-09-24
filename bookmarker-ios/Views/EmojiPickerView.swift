//
//  EmojiPickerView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/23/20.
//

import SwiftUI

struct EmojiPickerView: View {
    var columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        LazyVGrid(columns: columns) {
             ForEach((0...79), id: \.self) {
                 let codepoint = $0 + 0x1f600
                 let emoji = String(Character(UnicodeScalar(codepoint)!))
                 Text("\(emoji)")
             }
         }
        .font(.largeTitle)
    }
}

struct EmojiPickerView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerView()
    }
}
