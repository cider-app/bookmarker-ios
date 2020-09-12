//
//  ProtectedWithPlaceholderView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct ProtectedWithPlaceholderView<Content: View>: View {
    @EnvironmentObject var appState: AppState
    @State private var authViewIsPresented: Bool = false
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        if let authUser = self.appState.authUser {
            if authUser.isAnonymous {
                VStack {
                    Text("Create an account to get the most out of Cider")
                    
                    Button(action: {
                        self.authViewIsPresented = true
                    }) {
                        Text("Sign up")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                    }
                }
                .padding()
                .fullScreenCover(isPresented: self.$authViewIsPresented) {
                    AuthenticationView(isPresented: self.$authViewIsPresented)
                }
            } else {
                content
            }
        }
    }
}

//struct ProtectedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProtectedView()
//    }
//}
