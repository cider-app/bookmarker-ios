//
//  SignInView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var vm = SignInViewModel()
    
    func signIn() {
        self.vm.signInWithEmailAndPassword { (error) in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
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
            Button(action: {
                self.authViewModel.isSigningUp.toggle()
            }) {
                Text("Sign up")
            }
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
