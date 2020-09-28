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
        GridItem(.fixed(200))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .top, spacing: Constants.verticalSpacing) {
                ForEach(self.vm.folderFiles, id: \.id) { folderFile in
                    FolderFilesGridCellView(folderFile: folderFile)
                        .frame(width: 130)
                }
                
                VStack {
                    Spacer()
                    
                    Button(action: {}) {
                        HStack {
                            Text("More")
                            Image(systemName: Constants.Icon.arrowRight)
                        }
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Spacer()
                }
                .padding()
            }
            .padding(.horizontal)
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
