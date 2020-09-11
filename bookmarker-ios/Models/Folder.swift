//
//  Folder.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseFirestore

struct Folder: FirestoreModel {
    var title: String = ""
    var description: String = ""
    var secret: Bool = true
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let title = data[Constants.title] as? String
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.title = title
    }
    
    static var collectionRef: CollectionReference {
        return Firestore.firestore().collection(Constants.folders)
    }
}
