//
//  MembersListView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import SwiftUI

struct MembersListView: View {
    var members: [FolderUser]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(members, id: \.id) { member in
                    MembersListRowView(member: member)
                        .padding(.vertical)
                }
            }
        }
    }
}

//struct MembersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MembersListView()
//    }
//}
