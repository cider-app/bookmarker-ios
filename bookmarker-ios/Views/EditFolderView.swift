//
//  EditFolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct EditFolderView: View {
    @StateObject var vm = EditFolderViewModel()
    @Binding var isPresented: Bool
    var folder: Folder
    
    func update() {
        self.vm.update(folderId: self.folder.id) { (error) in
            if error == nil {
                self.isPresented = false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: self.$vm.title)
                }
                Section(header: Text("Description")) {
                    TextField("Name", text: self.$vm.description)
                }
                Section(header: Text("Visibility")) {
                    Toggle("Secret", isOn: self.$vm.secret)
                }
                Section(header: Text("Member permissions")) {
                    Toggle("Members can post", isOn: self.$vm.permissions.canEdit)
                    Toggle("Members can invite others", isOn: self.$vm.permissions.canManageMembers)
                }
            }
            .navigationTitle("Edit collection")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: Constants.Icon.close)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: update) {
                        Text("Save")
                    }
                }
            }
            .onAppear {
                self.vm.title = folder.title
                self.vm.description = folder.description
                self.vm.secret = folder.secret
                self.vm.permissions = folder.permissions
            }
        }
    }
}

//struct EditFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFolderView()
//    }
//}
