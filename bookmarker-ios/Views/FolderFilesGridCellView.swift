//
//  FolderFilesGridCellView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/23/20.
//

import SwiftUI

struct FolderFilesGridCellView: View {
    var folderFile: FolderFile
    @StateObject var imageLoader = URLImageStore()
    
    var body: some View {
        VStack {
            Group {
                if let image = self.imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Color(.systemGray5)
                }
            }
            .frame(width: 130, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
            
            HStack {
                Text(folderFile.title)
                    .font(Font.system(.subheadline))
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.imageLoader.loadImage(urlString: folderFile.imageUrl)
        }
    }
}

//struct FolderFilesGridCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesGridCellView()
//    }
//}
