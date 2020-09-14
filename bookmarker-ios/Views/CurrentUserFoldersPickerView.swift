//
//  CurrentUserFoldersPickerView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct CurrentUserFoldersPickerView: View {
    @EnvironmentObject var appState: AppState
    @Binding var selectedIndex: Int
    
    var body: some View {
        Picker("Collection", selection: $selectedIndex) {
            ForEach(0 ..< self.appState.currentUserFolders.count) {
                Text(self.appState.currentUserFolders[$0].title)
            }
        }
    }
}

struct CurrentUserFoldersPickerView_Previews: PreviewProvider {
    @State static var index: Int = 0
    static var previews: some View {
        CurrentUserFoldersPickerView(selectedIndex: $index)
    }
}
