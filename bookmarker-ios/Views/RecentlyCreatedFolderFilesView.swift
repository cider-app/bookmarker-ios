//
//  RecentlyCreatedFolderFilesView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/17/20.
//

import SwiftUI

struct RecentlyCreatedFolderFilesView: View {
    @StateObject var recentlyCreatedFilesVM = RecentlyCreatedFolderFilesViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                ForEach(self.recentlyCreatedFilesVM.folderFiles, id: \.id) { folderFile in
                    FolderFilesListRowView(folderFile: folderFile)
                }
            }
        }
    }
}

struct RecentlyCreatedFolderFilesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyCreatedFolderFilesView()
    }
}
