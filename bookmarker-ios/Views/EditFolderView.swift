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
                Section(
                    header: Text("Visibility"),
                    footer: Text("Secret collections require Face ID or a passcode to access")
                ) {
                    Toggle("Secret", isOn: self.$vm.secret)
                }
            }
            .navigationTitle("Edit collection")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: update) {
                        Text("Done")
                    }
                }
            }
            .onAppear {
                self.vm.title = folder.title
                self.vm.description = folder.description
                self.vm.secret = folder.secret
            }
        }
    }
}

//struct EditFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFolderView()
//    }
//}
