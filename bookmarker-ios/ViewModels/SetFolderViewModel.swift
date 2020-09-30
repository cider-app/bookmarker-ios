//
//  SetFolderViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import Foundation
import FirebaseDynamicLinks
import FirebaseFirestore
import FirebaseAuth

class SetFolderViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var secret: Bool = false
    @Published var permissions: Permissions = Permissions()
    @Published var emoji: String = Constants.defaultFolderEmoji
    @Published var color: String = Constants.defaultFolderColor
    @Published var isLoading: Bool = false
    
    func set(folder: Folder?, completion: ((Error?) -> Void)?) {
        if let folder = folder {
            self.update(folderId: folder.id, completion: completion)
        } else {
            self.create(completion: completion)
        }
    }
    
    func update(folderId: String, completion: ((Error?) -> Void)?) {
        isLoading = true
        
        Folder.collectionRef.document(folderId).updateData([
            Constants.title: title,
            Constants.description: description,
            Constants.secret: secret,
            Constants.emoji: emoji,
            Constants.color: color,
            Constants.permissions: permissions.toDictionary
        ]) { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error updating document: \(error)")
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }
    
    func create(completion: ((Error?) -> Void)?) {
        guard let authUser = Auth.auth().currentUser else { return }
        
        isLoading = true
        
        let db = Firestore.firestore()
        let batch = db.batch()
        
        let folderRef = Folder.collectionRef.document()
        let folderUserRef = FolderUser.subcollectionRef(parentDocId: folderRef.documentID).document(authUser.uid)
        let userFolderRef = UserFolder.subcollectionRef(parentDocId: authUser.uid).document(folderRef.documentID)
        
        let folder = Folder(id: folderRef.documentID, title: title, description: description, secret: secret, permissions: permissions, emoji: emoji, color: color, createdByUserId: authUser.uid)
        let folderUser = FolderUser(id: authUser.uid, docRef: folderUserRef)
        let userFolder = UserFolder(id: folderRef.documentID, docRef: userFolderRef, title: title, description: description, secret: secret, emoji: emoji, color: color)
        
        batch.setData(folder.toDictionary, forDocument: folderRef)
        batch.setData(folderUser.toDictionary, forDocument: folderUserRef)
        batch.setData(userFolder.toDictionary, forDocument: userFolderRef)
        
        batch.commit { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error creating folder: \(error)")
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }
}
