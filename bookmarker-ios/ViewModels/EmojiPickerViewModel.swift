//
//  EmojiPickerViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/28/20.
//

import Foundation

class EmojiPickerViewModel: ObservableObject {
    @Published var categorySelectionIndex: Int = 0
    var categories = ["😀", "🐶", "🍔"]
    
    var emoticonsRange = 0x1F600...0x1F64F
    var miscSymbolsAndPictoGraphsRange = 0x1F300...0x1F5FF
    var transportAndMapRange = 0x1F680...0x1F6FF
}
