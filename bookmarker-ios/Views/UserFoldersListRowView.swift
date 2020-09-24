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
        VStack(alignment: .center, spacing: Constants.verticalSpacing) {
            Text(userFolder.title)
                .font(Font.system(.title).weight(Constants.fontWeight))
            
            Text(userFolder.description)
                .font(Font.system(.subheadline))
            
//            HStack {
//                Spacer()
//
//                Text(self.userFolder.secret ? "🔒" : "🎉")
//            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(.systemBackground))
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.blue)))
//        .clipped()
//        .shadow(color: Color.gray.opacity(0.25), radius: 4, x: 0, y: 6)
        .padding(.horizontal)
    }
}

//struct UserFoldersListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFoldersListRowView()
//    }
//}
