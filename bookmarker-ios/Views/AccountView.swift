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
        Group {
            if self.appState.authUser != nil {
                Form {
                    Section {
                        Button(action: {
                            self.appState.signOut(completion: nil)
                        }) {
                            Text("Sign out")
                        }
                    }
                }
            } else {
                Button(action: {
                    self.authViewIsPresented = true
                }) {
                    Text("Sign up")
                }
                .fullScreenCover(isPresented: self.$authViewIsPresented) {
                    AuthenticationView(isPresented: self.$authViewIsPresented)
                }
            }
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
