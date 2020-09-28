//
//  NewFolderFileSelectUserFolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct NewFolderFileSelectUserFolderView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var vm: NewFolderFileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    func createFolderFile(folderId: String) {
        self.vm.selectedFolderId = folderId
        
        self.vm.create() { (error) in
            if error == nil {
                NotificationCenter.default.post(name: .didCompleteNewFile, object: nil)
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: Constants.Icon.back)
                }
                .buttonStyle(NavigationBarIconButtonStyle())
                
                Spacer()
            }
            .padding()
            
            SelectableUserFoldersListView(userFolders: self.appState.currentUserFolders) { (selectedUserFolder) in
                self.createFolderFile(folderId: selectedUserFolder.id)
            }
            .padding()
        }
        .disabled(self.vm.isLoading)
        .navigationBarHidden(true)
    }
}

//struct NewFolderFileSelectUserFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileSelectUserFolderView()
//    }
//}
