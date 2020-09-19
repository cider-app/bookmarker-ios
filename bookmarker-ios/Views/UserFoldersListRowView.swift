//
//  UserFoldersListRowView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct UserFoldersListRowView: View {
    var userFolder: UserFolder
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(userFolder.title)
                    .font(.headline)
                Text(userFolder.description)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.systemGray6)))
    }
}

//struct UserFoldersListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFoldersListRowView()
//    }
//}
