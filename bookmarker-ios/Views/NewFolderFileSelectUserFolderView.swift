//
//  NewFolderFileSelectUserFolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct NewFolderFileSelectUserFolderView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var newFolderFileVM: NewFolderFileViewModel
    
    func createFolderFile(folderId: String) {
        self.newFolderFileVM.create(folderId: folderId) { (error) in
            if error == nil {
                NotificationCenter.default.post(name: .didCompleteNewFile, object: nil)
            }
        }
    }
    
    var body: some View {
        SelectableUserFoldersListView(userFolders: self.appState.currentUserFolders) { (selectedUserFolder) in
            self.createFolderFile(folderId: selectedUserFolder.id)
        }
        .navigationTitle("Choose collection")
    }
}

//struct NewFolderFileSelectUserFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileSelectUserFolderView()
//    }
//}
