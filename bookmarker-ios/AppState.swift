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
}
