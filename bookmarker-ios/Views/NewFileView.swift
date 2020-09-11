//
//  NewFileView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct NewFileView: View {
    @EnvironmentObject var appState: AppState
    @State private var sheetIsPresented: Bool = false
    @State private var activeSheet: Sheet = .account
    @StateObject var vm = NewFileViewModel()
    
    enum Sheet {
        case account, selectFolder
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("https://...", text: self.$vm.link, onEditingChanged: { (isEditingChanged) in
                    
                }, onCommit: {
                    
                })
                
                Button(action: {
                    self.activeSheet = Sheet.selectFolder
                    self.sheetIsPresented = true
                }) {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.activeSheet = Sheet.account
                        self.sheetIsPresented = true
                    }) {
                        Image(systemName: Constants.Icon.account)
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                if activeSheet == Sheet.account {
                    AccountView(isPresented: $sheetIsPresented)
                        .environmentObject(self.appState)
                } else if activeSheet == Sheet.selectFolder {
                    Text("Select folder")
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteNewFile)) { (_) in
                if activeSheet == Sheet.selectFolder {
                    self.sheetIsPresented = false
                    self.vm.link = ""
                }
            }
        }
    }
}

struct NewFileView_Previews: PreviewProvider {
    static var previews: some View {
        NewFileView()
    }
}
