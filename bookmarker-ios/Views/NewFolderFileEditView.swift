//
//  NewFolderFileEditView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct NewFolderFileEditView: View {
    @ObservedObject var vm: NewFolderFileViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                Group {
                    if self.vm.metadata != nil {
                        VStack {
                            if let image = self.vm.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxHeight: 120)
                            }
                            HStack {
                                VStack {
                                    Text(self.vm.title)
                                        .font(.largeTitle)
                                    Text(self.vm.description)
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
                
                NavigationLink(destination: NewFolderFileSelectUserFolderView(vm: self.vm)) {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                }
                .padding()
            }
        }
    }
}

//struct NewFolderFileEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileEditView()
//    }
//}
