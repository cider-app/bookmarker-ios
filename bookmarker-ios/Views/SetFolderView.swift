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
                        }
                        .buttonStyle(NavigationBarIconButtonStyle())
                        
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

                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier())
                            ) {
                                TextField("Enter a name", text: self.$vm.title)
                                    .modifier(TextFieldViewModifier())
                            }
                            .padding(.horizontal)
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Description")

                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier())
                            ) {
                                TextField("Enter a description", text: self.$vm.description)
                                    .modifier(TextFieldViewModifier())
                                    
                            }
                            .padding(.horizontal)
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Visibility")

                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier()),
                                footer:
                                    HStack {
                                        Text("Secret collections require Face ID or a passcode to access")
                                            .font(Font.system(.caption))
                                            .foregroundColor(Color(.tertiaryLabel))
                                        
                                        Spacer()
                                    }
                            ) {
                                Toggle("Secret", isOn: self.$vm.secret)
                                    .toggleStyle(PrimaryToggleStyle())
                            }
                            .padding(.horizontal)
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Sharing")

                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier())
                            ) {
                                Toggle("Members can post", isOn: self.$vm.permissions.canEdit)
                                    .toggleStyle(PrimaryToggleStyle())
                                Toggle("Members can invite others", isOn: self.$vm.permissions.canManageMembers)
                                    .toggleStyle(PrimaryToggleStyle())
                            }
                            .padding(.horizontal)
                            
                            Section(
                                header:
                                    HStack {
                                        Text("Color")

                                        Spacer()
                                    }
                                    .modifier(SectionHeaderViewModifier())
                                    .padding(.horizontal)
                            ) {
                                ColorGridPickerView()
                            }
                        }
                    }
                    
                    Button(action: set) {
                        Text("Save")
                    }
                    .buttonStyle(PrimaryButtonStyle())
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