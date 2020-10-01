//
//  FolderUser.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseFirestore

struct FolderUser: FirestoreModel {
    init(id: String, docRef: DocumentReference) {
        self.id = id
        self.docRef = docRef
    }
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var docRef: DocumentReference
    
    var toDictionary: [String : Any] {
        return [
            Constants.userId: id
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data()
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.docRef = documentSnapshot.reference
    }
    
    static func subcollectionRef(parentDocId: String) -> CollectionReference {
        return Firestore.firestore().collection(Constants.folders).document(parentDocId).collection(Constants.folderUsers)
    }
    
    static func == (lhs: FolderUser, rhs: FolderUser) -> Bool {
        let isEqual = lhs.id == rhs.id
        return isEqual
    }
}
