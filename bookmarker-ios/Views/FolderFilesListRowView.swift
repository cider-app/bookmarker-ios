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
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(folderFile.title)
                    .font(Font.system(.headline).weight(.semibold))
                    .foregroundColor(Color(.label))
                    .lineLimit(3)
                
                Text(folderFile.link)
                    .font(Font.system(.subheadline).weight(.regular))
                    .foregroundColor(Color(.secondaryLabel))
                    .lineLimit(1)
                    .padding(.top, 4)
            }
            .padding(.vertical)
            
            Spacer()
            
            if let image = self.imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.folderFilesListRowViewSize, height: Constants.folderFilesListRowViewSize)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
                    .padding(.leading)
            }
        }
        .padding(.vertical, 4)
        .onAppear {
            self.imageLoader.loadImage(urlString: folderFile.imageUrl)
        }
    }
}

//struct FolderFilesListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListRowView()
//    }
//}
