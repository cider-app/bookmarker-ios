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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    ForEach(self.recentlyCreatedFilesVM.folderFiles, id: \.id) { folderFile in
                        FolderFilesListRowView(folderFile: folderFile)
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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
