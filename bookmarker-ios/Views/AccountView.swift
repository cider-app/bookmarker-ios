//
//  AccountView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    
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
                                    self.presentationMode.wrappedValue.dismiss()
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
                        self.presentationMode.wrappedValue.dismiss()
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
