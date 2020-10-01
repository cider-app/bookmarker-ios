//
//  NewFolderFileAddLinkView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct NewFolderFileAddLinkView: View {
    @ObservedObject var vm: NewFolderFileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            Spacer()
            
            TextField("https://...", text: self.$vm.link, onEditingChanged: { (isEditingChanged) in
                if isEditingChanged {
                    self.vm.error = nil
                }
            }, onCommit: {
                
            })
            .modifier(TextFieldViewModifier())
            
            Button(action: {
                self.vm.fetchLinkMetadata()
            }) {
                Text("Next")
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(self.vm.isLoading || self.vm.link.isEmpty)
            
            if let error = self.vm.error {
                Text(error)
            }
            
            NavigationLink(destination: NewFolderFileEditView(vm: self.vm), isActive: self.$vm.editFileNavLinkIsActive) {
                EmptyView()
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

//struct NewFolderFileAddLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileAddLinkView()
//    }
//}
