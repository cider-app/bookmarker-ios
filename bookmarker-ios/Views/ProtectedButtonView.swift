//
//  ProtectedButtonView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct ProtectedButtonView<Content: View>: View {
    @EnvironmentObject var appState: AppState
    @State private var authViewIsPresented: Bool = false
    let content: Content
    var action: () -> Void
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            if self.appState.authUser != nil && !self.appState.authUser!.isAnonymous {
                self.action()
            } else {
                self.authViewIsPresented = true
            }
        }) {
            content
        }
        .fullScreenCover(isPresented: $authViewIsPresented) {
            AuthenticationView(isPresented: $authViewIsPresented)
        }
    }
}

//struct ProtectedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProtectedButtonView()
//    }
//}
