//
//  CurrentUserFoldersView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct CurrentUserFoldersView: View {
    @EnvironmentObject var appState: AppState
    @State private var accountViewIsPresented: Bool = false
    @State private var newFolderViewIsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    ForEach(self.appState.currentUserFolders, id: \.id) { userFolder in
                        NavigationLink(destination: FolderView(folderId: userFolder.id), tag: userFolder.id, selection: self.$appState.currentHomeTabFolderId) {
                            UserFoldersListRowView(userFolder: userFolder)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.accountViewIsPresented = true
                    }) {
                        Image(systemName: Constants.Icon.account)
                    }
                    .sheet(isPresented: $accountViewIsPresented) {
                        AccountView(isPresented: $accountViewIsPresented)
                            .environmentObject(self.appState)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        self.newFolderViewIsPresented = true
                    }) {
                        Image(systemName: Constants.Icon.add)
                    }
                    .sheet(isPresented: self.$newFolderViewIsPresented) {
                        NewFolderView(isPresented: self.$newFolderViewIsPresented)
                    }
                }
            }
        }
    }
}

struct CurrentUserFoldersView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserFoldersView()
    }
}
