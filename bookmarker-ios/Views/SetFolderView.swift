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
                    ZStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: Constants.Icon.close)
                            }
                            .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false, alignment: .center))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text(folder != nil ? "Edit Collection" : "New Collection")
                                .modifier(NavigationTitleViewModifier())
                            
                            Spacer()
                        }
                    }
                    .modifier(NavigationBarViewModifier())
                    
                    HStack {
                        Spacer()
                        
                        Text(self.vm.emoji)
                            .font(.system(size: 60))
                        
                        Spacer()
                    }
                    
                    TextField("Enter a name", text: self.$vm.title)
                        .modifier(TextFieldViewModifier(variant: .filled))
                        .padding()
                    
                    Toggle("Secret", isOn: self.$vm.secret)
                        .toggleStyle(PrimaryToggleStyle())
                        .padding()
                    
                    EmojiPickerView(selectedEmoji: self.$vm.emoji)
                        .ignoresSafeArea(.all)
                        .padding(.top)
                    
                    Button(action: set) {
                        Text("Save")
                    }
                    .buttonStyle(CustomButtonStyle(variant: .contained, color: .primary, fullWidth: true, alignment: .center))
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                if let folder = self.folder {
                    self.vm.title = folder.title
                    self.vm.secret = folder.secret
                    self.vm.permissions = folder.permissions
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
