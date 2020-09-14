//
//  NewFolderFileAddLinkView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct NewFolderFileAddLinkView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm = NewFolderFileViewModel()
    @State private var accountViewIsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                TextField("https://...", text: self.$vm.link, onEditingChanged: { (isEditingChanged) in
                    if isEditingChanged {
                        self.vm.error = nil
                    }
                }, onCommit: {
                    
                })
                
                Button(action: {
                    self.vm.fetchLinkMetadata()
                }) {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                }
                .disabled(self.vm.isLoading || self.vm.link.isEmpty)
                
                if let error = self.vm.error {
                    Text(error)
                }
            }
            .padding()
            .ignoresSafeArea(.keyboard)
            .navigationTitle(Text("New Link"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.accountViewIsPresented = true
                    }) {
                        Image(systemName: Constants.Icon.account)
                    }
                    .sheet(isPresented: $accountViewIsPresented) {
                        AccountView(isPresented: $accountViewIsPresented)
                            .environmentObject(self.appState)
                    }
                }
            }
            .fullScreenCover(isPresented: self.$vm.editFolderFileViewIsPresented) {
                NewFolderFileEditView(isPresented: self.$vm.editFolderFileViewIsPresented, newFolderFileVM: self.vm)
                    .environmentObject(self.appState)
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteNewFile)) { (_) in
                self.vm.reset()
            }
        }
    }
}

//struct NewFolderFileAddLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileAddLinkView()
//    }
//}
