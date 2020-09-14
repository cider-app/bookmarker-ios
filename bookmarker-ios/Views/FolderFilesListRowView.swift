//
//  FolderFilesListRowView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct FolderFilesListRowView: View {
    @StateObject var imageLoader = URLImageStore()
    var folderFile: FolderFile
    
    var body: some View {
        HStack {
            Text(folderFile.title)
            Spacer()
            if let image = self.imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.folderFilesListRowViewSize, height: Constants.folderFilesListRowViewSize)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            }
        }
    }
}

//struct FolderFilesListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListRowView()
//    }
//}
