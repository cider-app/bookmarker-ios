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
    var folderId: String
    
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
    
    func addLink() {
        self.vm.addLink(folderId: folderId) { (error) in
            if error == nil {
                //  Dismiss keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    func share() {
        guard let folder = self.vm.folder else { return }
        
        if folder.sharingIsEnabled {
            self.vm.sheetIsPresented = true
            self.vm.activeSheet = .share
        } else {
            self.vm.alertIsPresented = true
            self.vm.activeAlert = .enableSharing
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    FolderFilesListView(folderFiles: self.vm.folderFiles)
                        .padding(.horizontal)
                    
                    if let folder = self.vm.folder {
                        NavigationLink(destination: SetFolderView(folder: folder), isActive: self.$vm.editNavLinkIsActive) {
                            EmptyView()
                        }
                    }
                    
                    HStack {
                        TextField("Save link", text: self.$vm.newLink)
                            .modifier(TextFieldViewModifier(variant: .filled))
                        
                        Spacer()
                        
                        if !self.vm.newLink.isEmpty {
                            Button(action: addLink) {
                                Text("Save")
                            }
                            .buttonStyle(PrimaryButtonStyle())
                            .disabled(self.vm.isLoading)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom)
                }
                
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: Constants.Icon.back)
                            }
                            .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                            .disabled(self.vm.isLoading)
                            
                            Spacer()
                            
                            IfIsFolderCreatorOrCanManageMembersView(folderViewModel: self.vm) {
                                Button(action: share) {
                                    Image(systemName: Constants.Icon.share)
                                }
                                .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                                .disabled(self.vm.isLoading)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            
                            if let folder = self.vm.folder {
                                Menu {
                                    IfIsFolderCreatorView(folderVM: self.vm) {
                                        Button(action: {
                                            self.vm.sheetIsPresented = true
                                            self.vm.activeSheet = .edit
                                        }) {
                                            Label("Edit collection", systemImage: Constants.Icon.edit)
                                        }
                                    }
                                    
                                    IfIsFolderCreatorOrCanManageMembersView(folderViewModel: self.vm) {
                                        Button(action: {
                                            self.vm.sheetIsPresented = true
                                            self.vm.activeSheet = .manageSharing
                                        }) {
                                            Label("Manage sharing", systemImage: Constants.Icon.members)
                                        }
                                    }
                
                                    IfIsFolderMemberView(folderVM: self.vm) {
                                        Button(action: {
                                            self.vm.alertIsPresented = true
                                            self.vm.activeAlert = .leave
                                        }) {
                                            Label("Leave collection", systemImage: Constants.Icon.leave)
                                        }
                                    }
                
                                    IfIsFolderCreatorView(folderVM: self.vm) {
                                        Button(action: {
                                            self.vm.alertIsPresented = true
                                            self.vm.activeAlert = .delete
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
                    
                    Spacer()
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
        .sheet(isPresented: self.$vm.sheetIsPresented) {
            switch self.vm.activeSheet {
            case .edit:
                if let folder = self.vm.folder {
                    SetFolderView(folder: folder)
                }
            case .add:
                NewFolderFileView(currentFolderId: self.folderId)
            case .manageSharing:
                if let folder = self.vm.folder {
                    ManageSharingView(folder: folder)
                        .environmentObject(self.appState)
                }
            case .share:
                if let folder = self.vm.folder, let url = URL(string: folder.shareLink) {
                    ActivityViewController(activityItems: [url])
                }
            case .viewLink:
                if let url = URL(string: self.vm.selectedLink) {
                    SafariView(url: url)
                        .ignoresSafeArea(.all)
                }
            }
        }
        .alert(isPresented: self.$vm.alertIsPresented) { () -> Alert in
            switch self.vm.activeAlert {
            case .leave:
                return Alert(
                    title: Text("Leave Collection?"),
                    message: Text("Are you sure?"),
                    primaryButton: .destructive(Text("Leave"), action: leave),
                    secondaryButton: .cancel()
                )
            case .delete:
                return Alert(
                    title: Text("Delete Collection?"),
                    message: Text("Are you sure?"),
                    primaryButton: .destructive(Text("Delete"), action: delete),
                    secondaryButton: .cancel()
                )
            case .enableSharing:
                return Alert(
                    title: Text("Share Collection with Others?"),
                    message: Text("Let anyone with the link see collection items and members."),
                    primaryButton: .default(Text("Turn on"), action: {
                        self.vm.enableLinkSharing(folder: self.vm.folder!)
                    }),
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
