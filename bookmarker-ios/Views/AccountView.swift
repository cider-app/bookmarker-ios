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
    @State private var authViewIsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                if let authUser = self.appState.authUser {
                    if authUser.isAnonymous {
                        Button(action: {
                            self.authViewIsPresented = true
                        }) {
                            Text("Sign up")
                        }
                        .fullScreenCover(isPresented: self.$authViewIsPresented) {
                            AuthenticationView(isPresented: self.$authViewIsPresented)
                        }
                    } else {
                        Form {
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
