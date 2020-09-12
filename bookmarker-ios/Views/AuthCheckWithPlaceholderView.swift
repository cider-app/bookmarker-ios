//
//  IfAuthenticatedView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import SwiftUI
import FirebaseAuth

struct IfAuthenticatedView<Content: View>: View {
    @EnvironmentObject var appState: AppState
    let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        //  First let auth perform the initial check to see if a user is signed in or not
        if self.appState.authStateFirstChanged {
            //  If a user is signed in, display the content
            if self.appState.authUser != nil {
                content
            }
            //  Otherwise, if a user is not signed in, sign him/her in anonymously
            else {
                Color(.systemBackground)
                .onAppear {
                    self.appState.signInAnonymously()
                }
            }
        } else {
            Color(.systemBackground)
        }
    }
}

struct AuthCheckWithPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        IfAuthenticatedView()
    }
}
