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
                ScrollView(.vertical) {
                    Section(
                        header:
                            HStack {
                                Text("Recently Saved")
                                    .textCase(.uppercase)
                                
                                Spacer()
                            }
                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                            .foregroundColor(Color(.tertiaryLabel))
                            .padding(.horizontal)
                            .padding(.top)
                    ) {
                        RecentlyCreatedFolderFilesView()
                    }
                    
                    Section(
                        header:
                            HStack {
                                Text("My Collections")
                                    .textCase(.uppercase)
                                
                                Spacer()
                                
                                Button(action: {
                                    self.vm.sheetIsPresented = true
                                    self.vm.activeSheet = .newFolder
                                }) {
                                    Image(systemName: Constants.Icon.addFolder)
                                }
                                .foregroundColor(Color(.secondaryLabel))
                            }
                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                            .foregroundColor(Color(.tertiaryLabel))
                            .padding(.horizontal)
                            .padding(.top)
                    ) {
                        LazyVStack(spacing: 16) {
                            NavigationLink(destination: FolderView(folderId: "vNgSFFeuYo05X59iNxfY")) {
                                HStack {
                                    Text("🥐")
                                        .font(.largeTitle)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color("Color1")))
                                    
                                    Text("Recipes")
                                        .font(Font.system(.title3).weight(Constants.fontWeight))
                                        .foregroundColor(Color.primary)
                                        .padding(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.compact.right")
                                        .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                                        .foregroundColor(Color(.quaternaryLabel))
                                }
                            }
//                            .buttonStyle(PlainButtonStyle())
                            .padding()
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.systemBackground)))
                            .clipped()
                            .shadow(color: Color(.systemGray4).opacity(0.2), radius: 4, x: 0, y: 6)
                            
                            HStack {
                                Text("🎬").font(.largeTitle)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color("Color2")))
                                
                                Text("Moves to watch")
                                    .font(Font.system(.title3).weight(Constants.fontWeight))
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.compact.right")
                                    .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                                    .foregroundColor(Color(.quaternaryLabel))
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.systemBackground)))
                            .clipped()
                            .shadow(color: Color(.systemGray2).opacity(0.2), radius: 4, x: 0, y: 6)
                            
                            HStack {
                                Text("🚣🏻‍♂️").font(.largeTitle)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color("Color3")))
                                
                                Text("Nature")
                                    .font(Font.system(.title3).weight(Constants.fontWeight))
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.compact.right")
                                    .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                                    .foregroundColor(Color(.quaternaryLabel))
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.systemBackground)))
                            .clipped()
                            .shadow(color: Color(.systemGray2).opacity(0.2), radius: 4, x: 0, y: 6)
                        }
                        .padding(.horizontal)
                        
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
                }
            }
        }
        .navigationTitle("Home")
        .navigationBarItems(
            leading:
                Button(action: {
                    self.vm.sheetIsPresented = true
                    self.vm.activeSheet = .account
                }) {
                    Image(systemName: Constants.Icon.account)
                        .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                        .foregroundColor(Color.primary)
                },
            trailing:
                Button(action: {
                    self.vm.sheetIsPresented = true
                    self.vm.activeSheet = .add
                }) {
                    Image(systemName: Constants.Icon.add)
                        .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                        .foregroundColor(Color.primary)
                }
            )
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
        
//        ZStack {
//            Color(.systemGray6)
//                .ignoresSafeArea()
//
//            VStack {
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text("Home")
//                                .font(Font.system(.title).weight(.heavy))
//                                .foregroundColor(Color.primary)
//                                .padding(.horizontal)
//
//                            Spacer()
//
//                            Button(action: {
//                                self.sheetIsPresented = true
//                                self.activeSheet = .add
//                            }) {
//                                HStack {
//                                    Image(systemName: Constants.Icon.add)
//                                }
//                                .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
//                                .foregroundColor(Color.primary)
//        //                        .padding(8)
//        //                        .padding(.horizontal, 8)
//        //                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.green))
//        //                        .clipped()
//        //                        .shadow(color: Color.gray.opacity(0.25), radius: 4, x: 0, y: 6)
//                            }
//
//                            Button(action: {
//                                self.sheetIsPresented = true
//                                self.activeSheet = .account
//                            }) {
//                                Image(systemName: Constants.Icon.account)
//                                    .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
//                                    .foregroundColor(Color.primary)
//                                    .padding(.horizontal)
//                            }
//                        }
//                        .padding(.top)
//
//                        Section(
//                            header:
//                                Text("Recently Saved")
//                                .padding(.horizontal)
//                                .padding(.vertical)
//                                .textCase(.uppercase)
//                                .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(.heavy))
//                                .foregroundColor(Color(.tertiaryLabel))
//                        ) {
//                            RecentlyCreatedFolderFilesView()
//                        }
//
//                        Section(
//                            header:
//                                Text("Collections")
//                                .padding(.horizontal)
//                                .padding(.vertical)
//                                .textCase(.uppercase)
//                                .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(.heavy))
//                                .foregroundColor(Color(.tertiaryLabel))
//
//                        ) {
//                            ForEach(self.appState.currentUserFolders, id: \.id) { userFolder in
//                                NavigationLink(destination: FolderView(folderId: userFolder.id), tag: userFolder.id, selection: self.$appState.foldersTabNavLinkSelection) {
//                                    UserFoldersListRowView(userFolder: userFolder)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//
//                        NavigationLink(destination: FolderView(folderId: self.deepLinkFolderNavLinkId), isActive: self.$deepLinkFolderNavLinkIsActive) {
//                            EmptyView()
//                        }
//                    }
//                }
//            }
//        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
