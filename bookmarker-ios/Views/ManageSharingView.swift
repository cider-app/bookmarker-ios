//
//  ManageSharingView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/15/20.
//

import SwiftUI

struct ManageSharingView: View {
    @StateObject var vm = ManageSharingViewModel()
    @StateObject var membersVM = MembersViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var activityViewIsPresented: Bool = false
    var folder: Folder
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: Constants.Icon.close)
                        }
                        .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text("Manage Sharing")
                            .modifier(NavigationTitleViewModifier())
                        
                        Spacer()
                    }
                }
                .modifier(NavigationBarViewModifier())
                
                ScrollView {
                    VStack(spacing: Constants.verticalSpacing) {
                        Section(
                            footer: !self.vm.linkSharingFooterMessage.isEmpty ? Text(self.vm.linkSharingFooterMessage)
                                    .modifier(SectionFooterViewModifier())
                                : nil
                        ) {
                            Toggle("Turn on link sharing", isOn: self.$vm.linkSharingToggleIsOn)
                                .toggleStyle(PrimaryToggleStyle())
                                .onReceive([self.vm.linkSharingToggleIsOn].publisher.first()) { (isOn) in
                                    self.vm.toggleLinkSharing(folder: self.folder)
                                }
                                .disabled(self.vm.isProcessingLinkSharingRequest)
                        }
                        
                        if !self.vm.shareLink.isEmpty {
                            Section(
                                header:
                                    HStack {
                                        Text("Permissions")
                                        
                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier())
                            ) {
                                Toggle("People can post", isOn: self.$vm.permissions.canEdit)
                                    .toggleStyle(PrimaryToggleStyle())
                                
                                Toggle("People can invite others", isOn: self.$vm.permissions.canManageMembers)
                                    .toggleStyle(PrimaryToggleStyle())
                            }
                            
                            if !self.membersVM.members.isEmpty {
                                Section(
                                    header:
                                        HStack {
                                            Text("Members")
                                            Spacer()
                                        }
                                        .modifier(SectionHeaderViewModifier())
                                ) {
                                    MembersListView(members: self.membersVM.members)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                
                if !self.vm.shareLink.isEmpty {
                    VStack {
                        Button(action: {
                            self.activityViewIsPresented = true
                        }) {
                            Text("Share to...")
                        }
                        .buttonStyle(CustomButtonStyle(variant: .contained, color: .primary, fullWidth: true))
                        
                        Button(action: {
                            
                        }) {
                            Text("Copy share link")
                        }
                        .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: true))
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                self.vm.shareLink = folder.shareLink
                self.vm.linkSharingToggleIsOn = !folder.shareLink.isEmpty
                self.vm.permissions.canEdit = folder.permissions.canEdit
                self.vm.permissions.canManageMembers = folder.permissions.canManageMembers
                self.vm.secret = folder.secret
                
                self.membersVM.listen(folderId: folder.id)
            }
            .onDisappear {
                self.membersVM.unlisten()
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
