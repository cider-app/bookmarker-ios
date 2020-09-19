//
//  AccountView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appState: AppState
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ProtectedWithPlaceholderView {
                Form {
                    if let authUser = self.appState.authUser {
                        Section {
                            Text(authUser.uid)
                        }
                    }
                    Section {
                        NavigationLink(destination: AccountPrivacyAndSecurityView()) {
                            Label("Privacy & Security", systemImage: Constants.Icon.security)
                        }
                    }
                    Section {
                        Button(action: {
                            self.appState.signOut { (error) in
                                if error == nil {
                                    self.isPresented = false
                                }
                            }
                        }) {
                            Text("Sign out")
                        }
                    }
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
            .navigationTitle(Text("Account"))
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
