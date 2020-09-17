//
//  NewFolderFileAddLinkView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct NewFolderFileAddLinkView: View {
    @ObservedObject var vm: NewFolderFileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            TextField("https://...", text: self.$vm.link, onEditingChanged: { (isEditingChanged) in
                if isEditingChanged {
                    self.vm.error = nil
                }
            }, onCommit: {
                
            })
            
            Button(action: {
                self.vm.fetchLinkMetadata()
            }) {
                Text("Next")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
            }
            .disabled(self.vm.isLoading || self.vm.link.isEmpty)
            
            if let error = self.vm.error {
                Text(error)
            }
            
            NavigationLink(destination: NewFolderFileEditView(vm: self.vm), isActive: self.$vm.editFileNavLinkIsActive) {
                EmptyView()
            }
        }
        .padding()
        .ignoresSafeArea(.keyboard)
        .navigationTitle(Text("New Link"))
    }
}

//struct NewFolderFileAddLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileAddLinkView()
//    }
//}
