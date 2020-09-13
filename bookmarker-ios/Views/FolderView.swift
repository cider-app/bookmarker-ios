//
//  FolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderView: View {
    @StateObject var vm = FolderViewModel()
    var folderId: String
    
    var body: some View {
        ScrollView {
            if let folder = self.vm.folder {
                Text(folder.description)
            }
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                ForEach(self.vm.folderFiles, id: \.id) { folderFile in
                    FolderFilesListRowView(folderFile: folderFile)
                }
            }
        }
        .navigationTitle(self.vm.folder != nil ? self.vm.folder!.title : "")
        .onAppear {
            self.vm.listenFolder(folderId: folderId)
        }
        .onDisappear {
            self.vm.unlistenFolder()
        }
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView()
//    }
//}
