//
//  UserFoldersGridCellView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/23/20.
//

import SwiftUI

struct UserFoldersGridCellView: View {
    var userFolder: UserFolder
    
    var body: some View {
        VStack {
            HStack {
                Text("🛳")
                    .font(.largeTitle)
                    
                Spacer()
            }
            
            HStack {
                Text(userFolder.title)
                    .font(Font.system(.title3).weight(Constants.fontWeight))
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color(.systemBackground)))
        .clipped()
        .shadow(color: Color(.systemGray4), radius: 4, x: 0, y: 4)
    }
}

//struct UserFoldersGridCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFoldersGridCellView()
//    }
//}
