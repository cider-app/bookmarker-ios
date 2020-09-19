//
//  FolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm = FolderViewModel()
    @State private var alertIsPresented: Bool = false
    @State private var activeAlert: FolderAlert = .leave
    @State private var sheetIsPresented: Bool = false
    @State private var activeSheet: FolderSheet = .edit
    @State private var selectedLink: String = ""
    var folderId: String
    
    enum FolderAlert {
        case leave
        case delete
    }
    
    enum FolderSheet {
        case add
        case edit
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
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                if let folder = self.vm.folder {
                    HStack {
                        Text(folder.description)
                        Spacer()
                    }
                }
                ForEach(self.vm.folderFiles, id: \.id) { folderFile in
                    Button(action: {
                        self.selectedLink = folderFile.link
                        self.activeSheet = .viewLink
                        self.sheetIsPresented = true
                    }) {
                        FolderFilesListRowView(folderFile: folderFile)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle(self.vm.folder != nil ? self.vm.folder!.title : "", displayMode: .large)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    self.sheetIsPresented = true
                    self.activeSheet = .add
                }) {
                    Image(systemName: Constants.Icon.write)
                }
                
                IfFolderLinkSharingIsEnabled(folder: self.vm.folder) {
                    Button(action: {
                        self.sheetIsPresented = true
                        self.activeSheet = .share
                    }) {
                        Image(systemName: Constants.Icon.share)
                    }
                }
                
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
                    Image(systemName: Constants.Icon.more)
                        .padding(.vertical)
                        .padding(.leading)
                }
            }
        }
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
            case .add:
                NewFolderFileView(currentFolderId: self.folderId)
            case .edit:
                if let folder = self.vm.folder {
                    EditFolderView(isPresented: self.$sheetIsPresented, folder: folder)
                }
            case .manageSharing:
                if let folder = self.vm.folder {
                    ManageSharingView(isPresented: self.$sheetIsPresented, folder: folder)
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
