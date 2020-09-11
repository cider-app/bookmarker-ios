//
//  SignUpViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    func signUpWithEmailAndPassword(completion: ((Error?) -> Void)?) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            if let error = error {
                print("Error signing up user: \(error.localizedDescription)")
                return
            }
        }
    }
}
