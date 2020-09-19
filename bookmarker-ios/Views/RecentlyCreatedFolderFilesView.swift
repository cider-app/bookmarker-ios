//
//  RecentlyCreatedFolderFilesView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/17/20.
//

import SwiftUI

struct RecentlyCreatedFolderFilesView: View {
    @StateObject var vm = RecentlyCreatedFolderFilesViewModel()
    
    let rows = [
        GridItem(.fixed(Constants.recentlyCreatedFolderFilesGridHeight))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(self.vm.folderFiles, id: \.id) { folderFile in
                    FolderFilesListGridView(folderFile: folderFile)
                }
            }
        }
        .onAppear {
            self.vm.listen()
        }
        .onDisappear {
            self.vm.unlisten()
        }
    }
}

struct RecentlyCreatedFolderFilesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyCreatedFolderFilesView()
    }
}
