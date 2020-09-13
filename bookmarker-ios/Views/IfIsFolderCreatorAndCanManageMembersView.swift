//
//  IfIsFolderCreatorOrCanManageMembersView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct IfIsFolderCreatorOrCanManageMembersView<Content: View>: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var folderVM: FolderViewModel
    let content: Content
    
    init(folderViewModel: FolderViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.folderVM = folderViewModel
        self.content = content()
    }
    
    var body: some View {
        Group {
            if let folder = self.folderVM.folder, let authUser = self.appState.authUser {
                //  If the authUser is the folder creator OR if the authUser is a member and the folder permissions allows managing members
                if folder.createdByUserId == authUser.uid || (self.folderVM.currentUserIsMember && folder.permissions.canManageMembers) {
                    content
                }
            }
        }
    }
}

//struct IfIsFolderCreatorAndCanManageMembersView_Previews: PreviewProvider {
//    static var previews: some View {
//        IfIsFolderCreatorOrCanManageMembersView()
//    }
//}
