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
            Text(userFolder.emoji)
                .font(.largeTitle)
            
            Text(userFolder.title)
                .font(Font.system(.title3).weight(Constants.fontWeight))
                .lineLimit(1)
                .foregroundColor(Color.primary)
                .padding(.leading)
            
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color(.systemBackground)))
    }
}

//struct UserFoldersListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFoldersListRowView()
//    }
//}
