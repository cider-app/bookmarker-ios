//
//  FolderFilesGridView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/27/20.
//

import SwiftUI

struct FolderFilesGridView: View {
    var folderFiles: [FolderFile]
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(folderFiles, id: \.id) { folderFile in
                    Text(folderFile.title)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color(.systemGray6)))
                        .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).stroke(Color(.systemGray6), lineWidth: 2))
//                    FolderFilesGridCellView(folderFile: folderFile)
                }
            }
            .padding(.horizontal)
        }
    }
}

//struct FolderFilesGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesGridView()
//    }
//}
