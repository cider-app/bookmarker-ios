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
    @Published var authStateFirstChanged: Bool = false
    @Published var selectedTab: Tabs = Tabs.home
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuth() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, authUser) in
            if let user = authUser {
                print("User \(user.uid) signed in. Anonymous: \(user.isAnonymous)")
                self.authUser = user
                
                do {
                    try Auth.auth().useUserAccessGroup("KDPC3776KJ.com.kennethlng.bookmarker.shared")
                } catch let error as NSError {
                    print("Error changing user access group: %@, ", error)
                }
            } else {
                print("No user signed in")
                self.authUser = nil 
            }
            
            self.authStateFirstChanged = true
        })
    }
    
    func unlistenAuth() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { (autDataResult, error) in
            if let error = error {
                print("Error signing in anonymously: \(error.localizedDescription)")
                return
            }
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
