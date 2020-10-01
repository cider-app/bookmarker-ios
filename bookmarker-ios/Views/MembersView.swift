//
//  MembersView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import SwiftUI

struct MembersView: View {
    @StateObject var vm = MembersViewModel()
    var folderId: String
    
    var body: some View {
        MembersListView(members: self.vm.members)
            .onAppear {
                self.vm.listen(folderId: folderId)
            }
            .onDisappear {
                self.vm.unlisten()
            }
    }
}

//struct MembersView_Previews: PreviewProvider {
//    static var previews: some View {
//        MembersView()
//    }
//}
