//
//  NewFolderFileView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct NewFolderFileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm = NewFolderFileViewModel()
    @State private var selectedCurrentUserFolderIndex: Int = 0
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                TextField("https://...", text: self.$vm.link, onEditingChanged: { (isEditingChanged) in
                    if isEditingChanged {
                        self.vm.error = nil
                    }
                }, onCommit: {
                    
                })
                
                NavigationLink(destination: NewFolderFileSelectUserFolderView(newFolderFileVM: self.vm), label: {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                })
                .disabled(self.vm.isLoading || self.vm.link.isEmpty)
                
                if let error = self.vm.error {
                    Text(error)
                }
            }
            .padding()
            .ignoresSafeArea(.keyboard)
            .navigationTitle(Text("Save Link"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: Constants.Icon.close)
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteNewFile)) { (_) in
                self.isPresented = false
            }
        }
    }
}

//struct NewFolderFileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFolderFileView()
//    }
//}
