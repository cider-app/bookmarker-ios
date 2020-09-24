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
                Text(userFolder.title)
                    .font(Font.system(.title3).weight(Constants.fontWeight))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.yellow))
    }
}

//struct UserFoldersGridCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserFoldersGridCellView()
//    }
//}
