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
    
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        self.vm.sheetIsPresented = true
                        self.vm.activeSheet = .account
                    }) {
                        Image(systemName: Constants.Icon.account)
                    }
                    .buttonStyle(NavigationBarIconButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        self.vm.sheetIsPresented = true
                        self.vm.activeSheet = .add
                    }) {
                        Image(systemName: Constants.Icon.add)
                    }
                    .buttonStyle(NavigationBarIconButtonStyle())
                }
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                ScrollView(.vertical) {
                    Section(
                        header:
                            HStack {
                                Text("Recently Saved")
                                
                                Spacer()
                            }
                            .modifier(SectionHeaderViewModifier())
                            .padding(.horizontal)
                    ) {
                        RecentlyCreatedFolderFilesView()
                    }
                    
                    Section(
                        header:
                            HStack {
                                Text("My Collections")
                                
                                Spacer()
                                
                                Button(action: {
                                    self.vm.sheetIsPresented = true
                                    self.vm.activeSheet = .newFolder
                                }) {
                                    Image(systemName: Constants.Icon.addFolder)
                                }
                                .foregroundColor(Color(.secondaryLabel))
                            }
                            .modifier(SectionHeaderViewModifier())
                    ) {
                        LazyVStack(spacing: 16) {
                            ForEach(self.appState.currentUserFolders, id: \.id) { userFolder in
                                NavigationLink(destination: FolderView(folderId: userFolder.id), tag: userFolder.id, selection: self.$appState.foldersTabNavLinkSelection) {
                                    UserFoldersListRowView(userFolder: userFolder)
                                }
                            }
                        }
                        
//                        LazyVGrid(columns: columns) {
//                            ForEach(self.appState.currentUserFolders, id: \.id) { userFolder in
//                                NavigationLink(destination: FolderView(folderId: userFolder.id), tag: userFolder.id, selection: self.$appState.foldersTabNavLinkSelection) {
//                                    UserFoldersGridCellView(userFolder: userFolder)
//                                }
//                                .frame(height: 200)
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
        .onOpenURL { (url) in
            self.vm.handleOpenedUrl(url)
        }
        .sheet(isPresented: self.$vm.sheetIsPresented) {
            if self.vm.activeSheet == .add {
                NewFolderFileView()
                    .environmentObject(self.appState)
            } else if self.vm.activeSheet == .account {
                AccountView()
                    .environmentObject(self.appState)
            } else if self.vm.activeSheet == .newFolder {
                SetFolderView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
