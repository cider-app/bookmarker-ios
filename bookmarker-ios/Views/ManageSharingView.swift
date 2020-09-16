//
//  ManageSharingView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/15/20.
//

import SwiftUI

struct ManageSharingView: View {
    @StateObject var vm = ManageSharingViewModel()
    @Binding var isPresented: Bool
    @State private var activityViewIsPresented: Bool = false
    var folder: Folder
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    footer: !self.vm.linkSharingFooterMessage.isEmpty ? Text(self.vm.linkSharingFooterMessage) : nil
                ) {
                    Toggle("Link sharing", isOn: self.$vm.linkSharingToggleIsOn)
                        .onReceive([self.vm.linkSharingToggleIsOn].publisher.first()) { (isOn) in
                            self.vm.toggleLinkSharing(folder: self.folder)
                        }
                        .disabled(self.vm.isProcessingLinkSharingRequest)
                    
                    if !self.vm.shareLink.isEmpty {
                        Button(action: {
                            
                        }) {
                            Text("Copy share link")
                        }
                        
                        Button(action: {
                            self.activityViewIsPresented = true
                        }) {
                            HStack {
                                Text("Share to...")
                                Spacer()
                                Image(systemName: Constants.Icon.share)
                            }
                        }
                    }
                }
                
                if !self.vm.shareLink.isEmpty {
                    Section(header: Text("Permissions")) {
                        Toggle("Members can post", isOn: self.$vm.permissions.canEdit)
                        Toggle("Members can invite others", isOn: self.$vm.permissions.canManageMembers)
                    }
                    Section(header: Text("Members")) {
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: Constants.Icon.close)
                    }
                }
            }
            .navigationTitle(Text("Manage sharing"))
            .onAppear {
                self.vm.shareLink = folder.shareLink
                self.vm.linkSharingToggleIsOn = !folder.shareLink.isEmpty
                self.vm.permissions.canEdit = folder.permissions.canEdit
                self.vm.permissions.canManageMembers = folder.permissions.canManageMembers
            }
            .sheet(isPresented: $activityViewIsPresented) {
                if let url = URL(string: self.vm.shareLink) {
                    ActivityViewController(activityItems: [url])
                }
            }
        }
    }
}

//struct ManageSharingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageSharingView()
//    }
//}
