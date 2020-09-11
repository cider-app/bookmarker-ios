//
//  FolderUser.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseFirestore

struct FolderUser: FirestoreModel {
    var userId: String
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var toDictionary: [String : Any] {
        return [
            Constants.userId: userId
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let userId = data[Constants.userId] as? String
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.userId = userId
    }
    
    static func subcollectionRef(parentDocId: String) -> CollectionReference {
        return Firestore.firestore().collection(Constants.folders).document(parentDocId).collection(Constants.folderUsers)
    }
    
    static func == (lhs: FolderUser, rhs: FolderUser) -> Bool {
        let isEqual = lhs.id == rhs.id
        return isEqual
    }
}
