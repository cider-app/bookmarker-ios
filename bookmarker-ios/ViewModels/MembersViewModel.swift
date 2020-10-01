//
//  MembersViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class MembersViewModel: ObservableObject {
    @Published var members = [FolderUser]()
    var listener: ListenerRegistration?
    
    func listen(folderId: String) {
        listener = FolderUser.subcollectionRef(parentDocId: folderId).addSnapshotListener({ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            var items = documents.compactMap {
                FolderUser(documentSnapshot: $0)
            }
            
            //  Move authUser to first of array, if authUser exists in this array
            if let authUser = Auth.auth().currentUser, let index = items.firstIndex(where: { $0.id == authUser.uid }) {
                let element = items.remove(at: index)
                items.insert(element, at: 0)
            }
            
            self.members = items
        })
    }
    
    func unlisten() {
        self.listener?.remove()
    }
}
