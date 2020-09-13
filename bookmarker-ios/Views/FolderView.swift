//
//  FolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderView: View {
    @StateObject var vm = FolderViewModel()
    @State private var infoViewIsPresented: Bool = false 
    var folderId: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                if let folder = self.vm.folder {
                    Text(folder.description)
                }
                ForEach(self.vm.folderFiles, id: \.id) { folderFile in
                    FolderFilesListRowView(folderFile: folderFile)
                }
            }
            .padding()
        }
        .navigationTitle(self.vm.folder != nil ? self.vm.folder!.title : "")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Menu {
                    Button(action: {
                        self.infoViewIsPresented = true
                    }) {
                        Text("Edit collection")
                    }
                } label: {
                    Image(systemName: Constants.Icon.more)
                }
            }
        }
        .onAppear {
            self.vm.listenFolder(folderId: folderId)
        }
        .onDisappear {
            self.vm.unlistenFolder()
        }
        .sheet(isPresented: self.$infoViewIsPresented) {
            if let folder = self.vm.folder {
                EditFolderView(isPresented: self.$infoViewIsPresented, folder: folder)
            }
        }
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView()
//    }
//}
