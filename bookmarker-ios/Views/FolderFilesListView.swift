//
//  FolderFilesListView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/27/20.
//

import SwiftUI

struct FolderFilesListView: View {
    var folderFiles: [FolderFile]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(folderFiles, id: \.id) { folderFile in
                    VStack {
                        Button(action: {
                        }) {
                            FolderFilesListRowView(folderFile: folderFile)
                        }
                        
                        Divider()
                    }
                }
            }
            .padding(.top, 60)
        }
    }
}

//struct FolderFilesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderFilesListView()
//    }
//}
