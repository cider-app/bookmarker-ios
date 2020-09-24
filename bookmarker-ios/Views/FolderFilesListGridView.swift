//
//  FolderFilesListGridView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/17/20.
//

import SwiftUI

struct FolderFilesListGridView: View {
    var folderFile: FolderFile
    @StateObject var imageLoader = URLImageStore()
    
    var body: some View {
        VStack {
            if let image = self.imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            }
            Text(folderFile.title)
                .font(Font.system(.caption))
        }
        .frame(width: Constants.recentlyCreatedFolderFilesGridWidth)
        .onAppear {
            self.imageLoader.loadImage(urlString: folderFile.imageUrl)
        }
    }
}

//struct FolderFilesListGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListGridView()
//    }
//}
