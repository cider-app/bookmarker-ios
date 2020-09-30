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
                            .buttonStyle(SecondaryButtonStyle())
                            
                            Spacer()
                            
                            Button(action: set) {
                                Text("Save")
                            }
                            .buttonStyle(PrimaryButtonStyle())
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
                            .font(.largeTitle)
                            .padding()
                        
                        Spacer()
                    }
                    
                    TextField("Enter a name", text: self.$vm.title)
                        .modifier(TextFieldViewModifier(variant: .filled))
                        .padding()
                    
                    EmojiPickerView(selectedEmoji: self.$vm.emoji)
                        .ignoresSafeArea(.all)
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
