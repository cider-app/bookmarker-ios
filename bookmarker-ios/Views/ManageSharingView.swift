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
    
    func close() {
        self.vm.updatePermissions(folderId: folder.id) { (error) in
            if error == nil {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    HStack {
                        Button(action: close) {
                            Image(systemName: Constants.Icon.close)
                        }
                        .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                        
                        Spacer()
                        
                        if self.vm.isLoading {
                            ProgressView()
                        }
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
                            HStack {
                                Text("Share with others")
                                
                                Spacer()
                                
                                Button(action: {
                                    if self.vm.sharingIsEnabled {
                                        self.vm.alertIsPresented = true
                                    } else {
                                        self.vm.enableLinkSharing(folder: folder)
                                    }
                                }) {
                                    if self.vm.sharingIsEnabled {
                                        Text("Turn off")
                                    } else {
                                        Text("Turn on")
                                    }
                                }
                                .buttonStyle(
                                    self.vm.sharingIsEnabled ?
                                        CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false, alignment: .center)
                                    :
                                        CustomButtonStyle(variant: .contained, color: .primary, fullWidth: false, alignment: .center)
                                )
                                .disabled(self.vm.isLoading)
                            }
                        }
                        
                        if self.vm.sharingIsEnabled {
                            Section(
                                header:
                                    HStack {
                                        Text("Permissions")
                                        
                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier()),
                                footer: !self.vm.permissionsFooterMessage.isEmpty ?
                                    HStack {
                                        Text(self.vm.permissionsFooterMessage)
                                        
                                        Spacer()
                                    }
                                    .modifier(SectionFooterViewModifier())
                                : nil
                            ) {
                                Toggle("People can post", isOn: self.$vm.permissions.canEdit)
                                    .toggleStyle(PrimaryToggleStyle())
                                    .disabled(self.vm.isLoading)
                                
                                Toggle("People can invite others", isOn: self.$vm.permissions.canManageMembers)
                                    .toggleStyle(PrimaryToggleStyle())
                                    .disabled(self.vm.isLoading)
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
                
                if self.vm.sharingIsEnabled {
                    VStack {
                        Button(action: {
                            self.activityViewIsPresented = true
                        }) {
                            Text("Share to...")
                        }
                        .buttonStyle(CustomButtonStyle(variant: .contained, color: .primary, fullWidth: true))
                        
                        Button(action: {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = self.vm.shareLink
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
                self.vm.sharingIsEnabled = folder.sharingIsEnabled
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
            .alert(isPresented: self.$vm.alertIsPresented) {
                Alert(
                    title: Text("Stop Sharing?"),
                    message: Text("If you stop sharing, other people will no longer have access to \(folder.title)"),
                    primaryButton: .destructive(Text("Stop Sharing"), action: {
                        self.vm.disableLinkSharing(folderId: folder.id)
                    }),
                    secondaryButton: .cancel())
            }
        }
    }
}

//struct ManageSharingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManageSharingView()
//    }
//}
