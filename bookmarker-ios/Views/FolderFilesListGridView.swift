//
//  FolderFilesListGridView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/17/20.
//

import SwiftUI

struct FolderFilesListGridView: View {
    var folderFile: FolderFile
    
    var body: some View {
        VStack {
            Text(folderFile.title)
                .lineLimit(2)
        }
        .padding()
        .frame(width: Constants.recentlyCreatedFolderFilesGridWidth)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.systemGray6)))
    }
}

//struct FolderFilesListGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListGridView()
//    }
//}
