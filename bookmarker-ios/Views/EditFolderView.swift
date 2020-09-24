//
//  EditFolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct EditFolderView: View {
    @StateObject var vm = EditFolderViewModel()
    @Environment(\.presentationMode) var presentationMode
    var folder: Folder
    
    func update() {
        self.vm.update(folderId: self.folder.id) { (error) in
            if error == nil {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                Section {
                    ColorGridPickerView()
                }
            }
            .navigationTitle("Edit collection")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
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
