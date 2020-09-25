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
                .padding()
                .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color("Color1")))
            
            Text(userFolder.title)
                .font(Font.system(.title3).weight(Constants.fontWeight))
                .foregroundColor(Color.primary)
                .padding(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.compact.right")
                .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                .foregroundColor(Color(.quaternaryLabel))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color(.systemBackground)))
        .clipped()
        .shadow(color: Color(.systemGray4).opacity(0.2), radius: 4, x: 0, y: 6)
    }
}

//struct UserFoldersListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFoldersListRowView()
//    }
//}
