//
//  NewFolderViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class NewFolderViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var secret: Bool = false
    @Published var permissions: Permissions = Permissions()
    @Published var isLoading: Bool = false
    
    func createFolder(completion: ((Error?) -> Void)?) {
        guard let authUser = Auth.auth().currentUser else { return }
        
        isLoading = true
        
        let db = Firestore.firestore()
        let batch = db.batch()
        
        let folderRef = Folder.collectionRef.document()
        let folderUserRef = FolderUser.subcollectionRef(parentDocId: folderRef.documentID).document(authUser.uid)
        let userFolderRef = UserFolder.subcollectionRef(parentDocId: authUser.uid).document(folderRef.documentID)
        
        let folder = Folder(id: folderRef.documentID, title: title, description: description, secret: secret, permissions: permissions, createdByUserId: authUser.uid)
        let folderUser = FolderUser(id: authUser.uid)
        let userFolder = UserFolder(id: folderRef.documentID, title: title, description: description, secret: secret)
        
        batch.setData(folder.toDictionary, forDocument: folderRef)
        batch.setData(folderUser.toDictionary, forDocument: folderUserRef)
        batch.setData(userFolder.toDictionary, forDocument: userFolderRef)
        
        batch.commit { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error creating folder: \(error)")
                if completion != nil {
                    completion!(error)
                }
            } else {
                if completion != nil {
                    completion!(nil)
                }
            }
        }
    }
}
