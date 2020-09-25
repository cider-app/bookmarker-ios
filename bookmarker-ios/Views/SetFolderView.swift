//
//  SetFolderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct SetFolderView: View {
    @StateObject var vm = SetFolderViewModel()
    @Environment(\.presentationMode) var presentationMode
    var folder: Folder? = nil
    
    func set() {
        self.vm.set(folder: folder) { (error) in
            if error == nil {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: Constants.Icon.close)
                                .font(Font.system(Constants.iconFontTextStyle).weight(Constants.fontWeight))
                                .foregroundColor(Color.primary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    ScrollView {
                        VStack {
                            Section {
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text(self.vm.emoji)
                                            .font(.largeTitle)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color("Color1")))
                                    }
                                    
                                    Spacer()
                                }
                            }
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Name")
                                            .textCase(.uppercase)
                                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                                            .foregroundColor(Color(.tertiaryLabel))

                                        Spacer()
                                    }
                                    .padding(.top)
                                    .padding(.horizontal)
                            ) {
                                TextField("Name", text: self.$vm.title)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).stroke(Color(.systemGray6), lineWidth: 2))
                                    .padding(.horizontal)
                            }
                            Section(
                                header:
                                    HStack {
                                        Text("Description")
                                            .textCase(.uppercase)
                                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                                            .foregroundColor(Color(.tertiaryLabel))

                                        Spacer()
                                    }
                                    .padding(.top)
                                    .padding(.horizontal)
                            ) {
                                TextField("Description", text: self.$vm.description)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).stroke(Color(.systemGray6), lineWidth: 2))
                                    .padding(.horizontal)
                            }
                            Section(
                                header:
                                    HStack {
                                        Text("Visibility")
                                            .textCase(.uppercase)
                                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                                            .foregroundColor(Color(.tertiaryLabel))

                                        Spacer()
                                    }
                                    .padding(.top)
                                    .padding(.horizontal),
                                footer:
                                    HStack {
                                        Text("Secret collections require Face ID or a passcode to access")
                                            .font(Font.system(.caption))
                                            .foregroundColor(Color(.tertiaryLabel))
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                            ) {
                                Toggle("Secret", isOn: self.$vm.secret)
                                    .padding(.horizontal)
                            }
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Sharing")
                                            .textCase(.uppercase)
                                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                                            .foregroundColor(Color(.tertiaryLabel))

                                        Spacer()
                                    }
                                    .padding(.top)
                                    .padding(.horizontal)
                            ) {
                                Toggle("Members can post", isOn: self.$vm.permissions.canEdit)
                                    .padding(.horizontal)
                                Toggle("Members can invite others", isOn: self.$vm.permissions.canManageMembers)
                                    .padding(.horizontal)
                            }
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Color")
                                            .textCase(.uppercase)
                                            .font(Font.system(Constants.sectionHeaderFontTextStyle).weight(Constants.fontWeight))
                                            .foregroundColor(Color(.tertiaryLabel))

                                        Spacer()
                                    }
                                    .padding(.top)
                                    .padding(.horizontal)
                            ) {
                                ColorGridPickerView()
                            }
                        }
                    }
                    
                    Button(action: set) {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous).fill(Color.primary))
                            .foregroundColor(Color(.systemBackground))
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                if let folder = self.folder {
                    self.vm.title = folder.title
                    self.vm.description = folder.description
                    self.vm.secret = folder.secret
                    self.vm.permissions = folder.permissions
                    self.vm.color = folder.color
                    self.vm.emoji = folder.emoji
                }
            }
        }
    }
}

//struct EditFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetFolderView()
//    }
//}
