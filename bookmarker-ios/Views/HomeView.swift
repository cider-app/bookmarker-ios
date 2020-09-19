//
//  HomeView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm = HomeViewModel()
    @State private var accountViewIsPresented: Bool = false
    @State private var deepLinkFolderNavLinkIsActive: Bool = false
    @State private var deepLinkFolderNavLinkId: String = ""
    @State private var newFolderFileViewIsPresented: Bool = false
    
    func handleOpenedUrl(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        if let queryItems = components.queryItems {
            if let linkIndex = queryItems.firstIndex(where: { $0.name == Constants.link }),
               let link = queryItems[linkIndex].value,
               let linkUrl = URL(string: link) {
                guard linkUrl.pathComponents.count >= 3 else { return }
                let section = linkUrl.pathComponents[1]
                let detail = linkUrl.pathComponents[2]
                
                switch section {
                case Constants.Path.collections:
                    self.deepLinkFolderNavLinkId = detail
                    self.deepLinkFolderNavLinkIsActive = true
                default:
                    break
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    Section(header: Text("Recently Saved")) {
                        RecentlyCreatedFolderFilesView()
                    }
                    
                    Section(header: Text("Collections")) {
                        ForEach(self.appState.currentUserFolders, id: \.id) { userFolder in
                            NavigationLink(destination: FolderView(folderId: userFolder.id), tag: userFolder.id, selection: self.$appState.foldersTabNavLinkSelection) {
                                UserFoldersListRowView(userFolder: userFolder)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    NavigationLink(destination: FolderView(folderId: self.deepLinkFolderNavLinkId), isActive: self.$deepLinkFolderNavLinkIsActive) {
                        EmptyView()
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
                        self.newFolderFileViewIsPresented = true
                    }) {
                        Image(systemName: Constants.Icon.write)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .onOpenURL { (url) in
                self.handleOpenedUrl(url)
            }
            .sheet(isPresented: $newFolderFileViewIsPresented) {
                NewFolderFileView()
                    .environmentObject(self.appState)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
