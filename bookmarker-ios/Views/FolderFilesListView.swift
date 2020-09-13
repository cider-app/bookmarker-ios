//
//  FolderFilesListView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderFilesListView: View {
    var folderFiles: [FolderFile]
    
    var body: some View {
        List {
            ForEach(folderFiles, id: \.id) { folderFile in
                FolderFilesListRowView(folderFile: folderFile)
            }
        }
    }
}

//struct FolderFilesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListView()
//    }
//}
