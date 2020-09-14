//
//  NewFolderFileEditView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct NewFolderFileEditView: View {
    @Binding var isPresented: Bool
    @ObservedObject var newFolderFileVM: NewFolderFileViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    Group {
                        if self.newFolderFileVM.metadata != nil {
                            VStack {
                                if let image = self.newFolderFileVM.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxHeight: 120)
                                }
                                HStack {
                                    VStack {
                                        Text(self.newFolderFileVM.title)
                                            .font(.largeTitle)
                                        Text(self.newFolderFileVM.description)
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                        } else {
                            Text("No metadata found")
                        }
                    }
                    
                    Spacer()
                }
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: NewFolderFileSelectUserFolderView(newFolderFileVM: self.newFolderFileVM)) {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                    }
                    .padding()
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
        }
    }
}

//struct NewFolderFileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileEditView()
//    }
//}
