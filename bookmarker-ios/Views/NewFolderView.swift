//
//  NewFolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI

struct NewFolderView: View {
    @StateObject var vm = NewFolderViewModel()
    @Binding var isPresented: Bool
    
    func create() {
        self.vm.createFolder { (error) in
            if error == nil {
                self.isPresented = false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    TextField("Enter a name", text: self.$vm.title)
                    TextField("Enter a description", text: self.$vm.description)
                    Toggle("Secret", isOn: self.$vm.secret)
                    Toggle("Members can post", isOn: self.$vm.permissions.canEdit)
                    Toggle("Members can invite others", isOn: self.$vm.permissions.canManageMembers)
                    Button(action: create) {
                        Text("Create folder")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                    }
                }
                .padding()
            }
            .navigationTitle("New collection")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: Constants.Icon.close)
                    }
                }
            }
        }
    }
}

//struct NewFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderView()
//    }
//}
