//
//  FolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = FolderViewModel()
    @State private var alertIsPresented: Bool = false
    @State private var activeAlert: FolderAlert = .leave
    @State private var sheetIsPresented: Bool = false
    @State private var activeSheet: FolderSheet = .add
    @State private var selectedLink: String = ""
    @State private var editNavLinkIsActive: Bool = false
    var folderId: String
    
    @State private var text: String = ""
    
    enum FolderAlert {
        case leave
        case delete
    }
    
    enum FolderSheet {
        case edit
        case add
        case manageSharing
        case share
        case viewLink
    }
    
    func leave() {
        self.vm.leave(folderId: folderId) { (error) in
            if error == nil {
                self.appState.foldersTabNavLinkSelection = nil
            }
        }
    }
    
    func delete() {
        self.vm.delete(folderId: folderId) { (error) in
            if error == nil {
                self.appState.foldersTabNavLinkSelection = nil
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: Constants.Icon.back)
                            }
                            .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                            
                            Spacer()
                            
                            IfFolderLinkSharingIsEnabled(folder: self.vm.folder) {
                                Button(action: {
                                    self.sheetIsPresented = true
                                    self.activeSheet = .share
                                }) {
                                    Image(systemName: Constants.Icon.share)
                                }
                                .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            
                            if let folder = self.vm.folder {
                                Menu {
                                    IfIsFolderCreatorView(folderVM: self.vm) {
                                        Button(action: {
                                            self.sheetIsPresented = true
                                            self.activeSheet = .edit
                                        }) {
                                            Label("Edit collection", systemImage: Constants.Icon.edit)
                                        }
                                    }
                                    
                                    IfIsFolderCreatorOrCanManageMembersView(folderViewModel: self.vm) {
                                        Button(action: {
                                            self.sheetIsPresented = true
                                            self.activeSheet = .manageSharing
                                        }) {
                                            Label("Manage sharing", systemImage: Constants.Icon.members)
                                        }
                                    }
                
                                    IfIsFolderMemberView(folderVM: self.vm) {
                                        Button(action: {
                                            self.alertIsPresented = true
                                            self.activeAlert = .leave
                                        }) {
                                            Label("Leave collection", systemImage: Constants.Icon.leave)
                                        }
                                    }
                
                                    IfIsFolderCreatorView(folderVM: self.vm) {
                                        Button(action: {
                                            self.alertIsPresented = true
                                            self.activeAlert = .delete
                                        }) {
                                            Label("Delete collection", systemImage: Constants.Icon.delete)
                                        }
                                    }
                                } label: {
                                    Text("\(folder.emoji) \(folder.title)")
                                        .modifier(NavigationTitleViewModifier())
                                }
                                .menuStyle(CustomMenuStyle())
                            }
                            
                            Spacer()
                        }
                    }
                    
                    FolderFilesListView(folderFiles: self.vm.folderFiles)
                        .padding(.horizontal)
                    
                    if let folder = self.vm.folder {
                        NavigationLink(destination: SetFolderView(folder: folder), isActive: $editNavLinkIsActive) {
                            EmptyView()
                        }
                    }
                    
                    HStack {
                        TextField("Save link", text: self.$text)
                            .modifier(TextFieldViewModifier(variant: .filled))
                        
                        Spacer()
                        
                        if !self.text.isEmpty {
                            Button(action: {
                                
                            }) {
                                Text("Save")
                            }
                            .buttonStyle(PrimaryButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            self.vm.listenFolder(folderId: folderId)
            self.vm.listenFolderFiles(folderId: folderId)
            self.vm.getCurrentUserMembership(folderId: folderId)
        }
        .onDisappear {
            self.vm.unlistenFolder()
            self.vm.unlistenFolderFiles()
        }
        .sheet(isPresented: self.$sheetIsPresented) {
            switch self.activeSheet {
            case .edit:
                if let folder = self.vm.folder {
                    SetFolderView(folder: folder)
                }
            case .add:
                NewFolderFileView(currentFolderId: self.folderId)
            case .manageSharing:
                if let folder = self.vm.folder {
                    ManageSharingView(folder: folder)
                }
            case .share:
                if let folder = self.vm.folder, let url = URL(string: folder.shareLink) {
                    ActivityViewController(activityItems: [url])
                }
            case .viewLink:
                if let url = URL(string: self.selectedLink) {
                    SafariView(url: url)
                        .ignoresSafeArea(.all)
                }
            }
        }
        .alert(isPresented: self.$alertIsPresented) { () -> Alert in
            switch self.activeAlert {
            case .leave:
                return Alert(
                    title: Text("Leave collection"),
                    message: Text("Are you sure?"),
                    primaryButton: .destructive(Text("Leave"), action: leave),
                    secondaryButton: .cancel()
                )
            case .delete:
                return Alert(
                    title: Text("Delete collection"),
                    message: Text("Are you sure?"),
                    primaryButton: .destructive(Text("Delete"), action: delete),
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView()
//    }
//}
