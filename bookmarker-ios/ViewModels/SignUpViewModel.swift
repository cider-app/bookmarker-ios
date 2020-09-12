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
            
            guard let authUser = result?.user else { return }
            authUser.reload(completion: nil)
        }
    }
    
    func signUpAnonymousUserWithEmailAndPassword(completion: ((Error?) -> Void)?) {
        guard let authUser = Auth.auth().currentUser else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        authUser.link(with: credential) { (authDataResult, error) in
            if let error = error {
                print("Error linking anonymous user with email and password: \(error.localizedDescription)")
                if completion != nil {
                    completion!(error)
                }
                return
            }
            
            authUser.reload(completion: nil)
            
            if completion != nil {
                completion!(nil)
            }
        }
    }
}
