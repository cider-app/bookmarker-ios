//
//  SignUpView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var vm = SignUpViewModel()
    
    func signUp() {
        self.vm.signUpWithEmailAndPassword { (error) in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                return 
            }
            
            NotificationCenter.default.post(name: .didCompleteAuthentication, object: nil)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: self.$vm.email)
            SecureField("Password", text: self.$vm.password)
            Button(action: signUp) {
                Text("Sign up")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.primary))
                    .keyboardType(.emailAddress)
            }
            Button(action: {
                self.authViewModel.isSigningUp.toggle()
            }) {
                Text("Log in")
            }
        }
        .padding()
        .navigationTitle("Sign up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
