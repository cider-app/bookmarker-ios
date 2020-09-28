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
    
    @State private var text: String = ""
    
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.vm.sheetIsPresented = true
                        self.vm.activeSheet = .account
                    }) {
                        Image(systemName: Constants.Icon.account)
                            .font(Font.system(.title2).weight(Constants.fontWeight))
                            .foregroundColor(Color(.systemGray))
                    }
                }
                .modifier(NavigationBarViewModifier())
                
                ScrollView(.vertical) {
                    Section(
                        header:
                            HStack {
                                Text("My Collections")
                                
                                Spacer()
                            }
                            .modifier(SectionHeaderViewModifier())
                    ) {
                        LazyVStack(spacing: 16) {
                            ForEach(self.appState.currentUserFolders, id: \.id) { userFolder in
                                NavigationLink(destination: FolderView(folderId: userFolder.id), tag: userFolder.id, selection: self.$appState.foldersTabNavLinkSelection) {
                                    ZStack {
                                        UserFoldersListRowView(userFolder: userFolder)
                                        
                                        HStack {
                                            Spacer()
                                            
                                            Image(systemName: Constants.Icon.compactForward)
                                                .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                                                .foregroundColor(Color(.quaternaryLabel))
                                        }
                                        .padding()
                                    }
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
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.vm.sheetIsPresented = true
                        self.vm.activeSheet = .newFolder
                    }) {
                        HStack {
                            Image(systemName: Constants.Icon.addFolder)
                            Text("New")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                    Spacer()
                }
                .padding()
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
