//
//  SelectableUserFoldersListView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct SelectableUserFoldersListView: View {
    var userFolders: [UserFolder]
    var onUserFolderSelected: (UserFolder) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                ForEach(userFolders, id: \.id) { userFolder in
                    HStack {
                        Button(action: {
                            self.onUserFolderSelected(userFolder)
                        }) {
                            Text(userFolder.title)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

//struct SelectableUserFoldersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectableUserFoldersListView()
//    }
//}
