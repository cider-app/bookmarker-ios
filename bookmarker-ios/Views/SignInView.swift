//
//  SignInView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var vm = SignInViewModel()
    
    func signIn() {
        self.vm.signInWithEmailAndPassword { (error) in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
            //  Refresh the appState's reference of the authUser
            guard let authUser = Auth.auth().currentUser else { return }
            self.appState.authUser = authUser
            
            NotificationCenter.default.post(name: .didCompleteAuthentication, object: nil)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: self.$vm.email)
                .keyboardType(.emailAddress)
            SecureField("Password", text: self.$vm.password)
            Button(action: signIn) {
                Text("Log in")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
            }
            .disabled(self.vm.isLoading)
            Button(action: {
                self.authViewModel.isSigningUp.toggle()
            }) {
                Text("Sign up")
            }
            .disabled(self.vm.isLoading)
        }
        .padding()
        .navigationTitle("Log in")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
