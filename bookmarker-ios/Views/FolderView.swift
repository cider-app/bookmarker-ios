//
//  FolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderView: View {
    @StateObject var vm = FolderViewModel()
    
    var body: some View {
        FolderFilesListView(folderFiles: self.vm.folderFiles)
            .navigationTitle(self.vm.folder != nil ? self.vm.folder!.title : "")
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
