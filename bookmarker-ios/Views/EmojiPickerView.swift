//
//  EmojiPickerView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/23/20.
//

import SwiftUI

struct EmojiPickerView: View {
    @StateObject var vm = EmojiPickerViewModel()
    @Binding var selectedEmoji: String
    
    var body: some View {
        VStack {
            Picker(selection: self.$vm.categorySelectionIndex, label: Text("Emojis")) {
                ForEach(0 ..< self.vm.categories.count) {
                    Text(self.vm.categories[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TabView(selection: self.$vm.categorySelectionIndex) {
                SelectableEmojisGridView(emojisRange: self.vm.emoticonsRange) { (selectedEmoji) in
                    self.selectedEmoji = selectedEmoji
                }
                .tag(0)
                
                SelectableEmojisGridView(emojisRange: self.vm.miscSymbolsAndPictoGraphsRange) { (selectedEmoji) in
                    self.selectedEmoji = selectedEmoji
                }
                .tag(1)
                
                SelectableEmojisGridView(emojisRange: self.vm.transportAndMapRange) { (selectedEmoji) in
                    self.selectedEmoji = selectedEmoji
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

//struct EmojiPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiPickerView()
//    }
//}
