//
//  FolderFilesListRowView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderFilesListRowView: View {
    var folderFile: FolderFile
    
    var body: some View {
        HStack {
            Text(folderFile.title)
            Spacer()
        }
    }
}

//struct FolderFilesListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListRowView()
//    }
//}
