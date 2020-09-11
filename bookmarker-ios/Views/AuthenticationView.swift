//
//  AuthenticationView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var vm = AuthenticationViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Group {
                if self.vm.isSigningUp {
                    SignUpView()
                        .environmentObject(self.vm)
                } else {
                    SignInView()
                        .environmentObject(self.vm)
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
            .onReceive(NotificationCenter.default.publisher(for: .didCompleteAuthentication)) { (_) in
                self.isPresented = false
            }
        }
    }
}

//struct AuthenticationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticationView()
//    }
//}
