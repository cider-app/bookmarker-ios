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
    @StateObject var recentlyCreatedFilesVM = RecentlyCreatedFolderFilesViewModel()
    @State private var accountViewIsPresented: Bool = false
    @State private var foldersNavLinkIsActive: Bool = false
    @State private var foldersNavLinkId: String = ""
    
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
                    self.foldersNavLinkId = detail
                    self.foldersNavLinkIsActive = true
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
                    ForEach(self.recentlyCreatedFilesVM.folderFiles, id: \.id) { folderFile in
                        FolderFilesListRowView(folderFile: folderFile)
                    }
                    NavigationLink(destination: FolderView(folderId: self.foldersNavLinkId), isActive: $foldersNavLinkIsActive) {
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
            }
            .onAppear {
                self.recentlyCreatedFilesVM.listen()
            }
            .onDisappear {
                self.recentlyCreatedFilesVM.unlisten()
            }
            .onOpenURL { (url) in
                self.handleOpenedUrl(url)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
