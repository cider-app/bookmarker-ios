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
            VStack(alignment: .leading) {
                Text(folderFile.title)
                    .font(Font.system(.headline).weight(Constants.fontWeight))
                    .foregroundColor(Color(.label))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(.vertical)
            
            Spacer()
            
            if let image = self.imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.folderFilesListRowViewSize, height: Constants.folderFilesListRowViewSize)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    .clipped()
                    .shadow(color: Color(.systemGray2).opacity(0.2), radius: 4, x: 0, y: 4)
            }
        }
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
