//
//  NewFolderFileView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct NewFolderFileView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm = NewFolderFileViewModel()
    var currentFolderId: String?
    
    init(currentFolderId: String? = nil) {
        self.currentFolderId = currentFolderId
    }
    
    var body: some View {
        NavigationView {
            NewFolderFileAddLinkView(vm: self.vm)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: Constants.Icon.close)
                        }
                    }
                }
                .onAppear {
                    self.vm.selectedFolderId = currentFolderId
                }
                .onReceive(NotificationCenter.default.publisher(for: .didCompleteNewFile)) { (_) in
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

//struct NewFolderFileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileView()
//    }
//}
