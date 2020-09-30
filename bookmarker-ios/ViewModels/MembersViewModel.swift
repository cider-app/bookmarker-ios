//
//  MembersViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import Foundation
import FirebaseFirestore

class MembersViewModel: ObservableObject {
    @Published var members = [FolderUser]()
    var listener: ListenerRegistration?
    
    func listen(folderId: String) {
        listener = FolderUser.subcollectionRef(parentDocId: folderId).addSnapshotListener({ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let items = documents.compactMap {
                FolderUser(documentSnapshot: $0)
            }
            self.members = items
        })
    }
    
    func unlisten() {
        self.listener?.remove()
    }
}
