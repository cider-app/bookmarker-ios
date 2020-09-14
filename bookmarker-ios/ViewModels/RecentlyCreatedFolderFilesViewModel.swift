//
//  RecentlyCreatedFolderFilesViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class RecentlyCreatedFolderFilesViewModel: ObservableObject {
    @Published var folderFiles = [FolderFile]()
    var listener: ListenerRegistration?
    
    func listen() {
        guard let authUser = Auth.auth().currentUser else { return }
        listener = Firestore.firestore().collectionGroup(Constants.folderFiles)
            .whereField(Constants.createdByUserId, isEqualTo: authUser.uid)
            .addSnapshotListener({ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let items = documents.compactMap {
                FolderFile(documentSnapshot: $0)
            }
            self.folderFiles = items
        })
    }
    
    func unlisten() {
        listener?.remove()
    }
}
