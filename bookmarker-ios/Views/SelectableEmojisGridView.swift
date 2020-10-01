//
//  SelectableEmojisGridView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/28/20.
//

import SwiftUI

struct SelectableEmojisGridView: View {
    var emojisRange: ClosedRange<Int>
    var columns = [GridItem(.adaptive(minimum: 60))]
    var onClick: (String) -> Void
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                 ForEach((emojisRange), id: \.self) {
                    if let unicodeScalar = UnicodeScalar($0) {
                        let emoji = String(unicodeScalar)
                        Button(action: {
                            self.onClick(emoji)
                        }) {
                            Text("\(emoji)")
                        }
                    }
                 }
             }
            .font(.largeTitle)
        }
    }
}

//struct SelectableEmojisGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectableEmojisGridView()
//    }
//}
