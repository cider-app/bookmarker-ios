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
                                    .padding()
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
                    
                    Button(action: update) {
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
            .navigationTitle("Edit collection")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
//                            .font(Font.system(.body).weight(Constants.fontWeight))
                            .foregroundColor(Color.primary)
                    },
                trailing:
                    Button(action: update) {
                        Text("Done")
//                            .font(Font.system(.body).weight(Constants.fontWeight))
                            .foregroundColor(Color.primary)
                    }
                )
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
