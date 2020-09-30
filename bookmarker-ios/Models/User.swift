//
//  User.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseFirestore

struct User: FirestoreModel {
    var id: String
    var username: String = ""
    var docRef: DocumentReference
    
    var toDictionary: [String : Any] {
        return [
            Constants.username: username
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data()
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.docRef = documentSnapshot.reference
        self.username = data[Constants.username] as? String ?? ""
    }
    
    static var collectionRef: CollectionReference {
        return Firestore.firestore().collection(Constants.users)
    }
}
