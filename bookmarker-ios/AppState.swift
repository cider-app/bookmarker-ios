//
//  AppState.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseAuth

class AppState: ObservableObject {
    @Published var authUser: FirebaseAuth.User?
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuth() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, authUser) in
            if let user = authUser {
                self.authUser = user
                
                do {
                    try Auth.auth().useUserAccessGroup("KDPC3776KJ.com.kennethlng.bookmarker.shared")
                } catch let error as NSError {
                    print("Error changing user access group: %@, ", error)
                }
            } else {
                self.authUser = nil 
            }
        })
    }
    
    func unlistenAuth() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signOut(completion: ((Error?) -> Void)?) {
        do {
            try Auth.auth().signOut()
            if completion != nil {
                completion!(nil)
            }
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
            if completion != nil {
                completion!(signOutError)
            }
        }
    }
}
