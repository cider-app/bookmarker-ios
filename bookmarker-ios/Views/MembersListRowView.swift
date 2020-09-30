//
//  MembersListRowView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import SwiftUI

struct MembersListRowView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm = MembersListRowViewModel()
    var member: FolderUser
    @State private var alertIsPresented: Bool = false
    
    var body: some View {
        HStack {
            Text(member.id)
                .lineLimit(1)
            
            Spacer()
            
            if let authUser = appState.authUser, member.id != authUser.uid {
                Button(action: {
                    self.alertIsPresented = true
                }) {
                    Image(systemName: Constants.Icon.close)
                        .foregroundColor(Color(.systemGray))
                        .padding(.horizontal)
                }
            }
        }
        .alert(isPresented: $alertIsPresented) {
            Alert(
                title: Text("Remove person from collection?"),
                primaryButton: .destructive(Text("Remove"), action: {
                    self.vm.delete(docRef: member.docRef)
                }),
                secondaryButton: .cancel())
        }
    }
}

//struct MembersListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MembersListRowView()
//    }
//}
