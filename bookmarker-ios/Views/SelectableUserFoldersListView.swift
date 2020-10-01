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
            VStack(spacing: 16) {
                ForEach(userFolders, id: \.id) { userFolder in
                    Button(action: {
                        self.onUserFolderSelected(userFolder)
                    }) {
                        HStack(spacing: 16) {
                            Text(userFolder.emoji)
                                .font(.title3)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color("Color1")))
                            
                            Text(userFolder.title)
                                .font(Font.system(.headline).weight(Constants.fontWeight))
                                .foregroundColor(Color.primary)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

//struct SelectableUserFoldersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectableUserFoldersListView()
//    }
//}
