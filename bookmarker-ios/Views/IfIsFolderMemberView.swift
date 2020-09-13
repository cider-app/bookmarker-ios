//
//  IfIsFolderMemberView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct IfIsFolderMemberView<Content: View>: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var folderVM: FolderViewModel
    let content: Content
    
    init(folderVM: FolderViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.folderVM = folderVM
        self.content = content()
    }
    
    var body: some View {
        Group {
            if self.folderVM.currentUserIsMember {
                content
            }
        }
    }
}

//struct IfIsFolderMemberView_Previews: PreviewProvider {
//    static var previews: some View {
//        IfIsFolderMemberView()
//    }
//}
