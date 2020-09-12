//
//  UserFoldersViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserFoldersViewModel: ObservableObject {
    @Published var userFolders = [UserFolder]()
    var listener: ListenerRegistration?
    
    func listen(userId: String) {
        listener = UserFolder.subcollectionRef(parentDocId: userId).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let items = documents.compactMap {
                UserFolder(documentSnapshot: $0)
            }
            self.userFolders = items
        }
    }
    
    func unlisten() {
        listener?.remove()
    }
}
