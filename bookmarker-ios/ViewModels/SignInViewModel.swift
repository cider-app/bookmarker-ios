//
//  SignInViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    func signInWithEmailAndPassword(completion: ((Error?) -> Void)?) {
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            
            if let error = error {
                print("Error signing in with email and password: \(error.localizedDescription)")
                if completion != nil {
                    completion!(error)
                }
                return
            }
            
            if completion != nil {
                completion!(nil)
            }
        }
    }
}
