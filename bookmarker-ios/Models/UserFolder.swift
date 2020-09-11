//
//  UserFolder.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseFirestore

struct UserFolder: FirestoreModel {
    var title: String = ""
    var description: String = ""
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title,
            Constants.description: description
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let title = data[Constants.title] as? String
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.title = title
        self.description = data[Constants.description] as? String ?? ""
    }
    
    static func subcollectionRef(parentDocId: String) -> CollectionReference {
        return Firestore.firestore().collection(Constants.users).document(parentDocId).collection(Constants.userFolders)
    }
    
    static func == (lhs: UserFolder, rhs: UserFolder) -> Bool {
        let isEqual = lhs.id == rhs.id
        return isEqual
    }
}
