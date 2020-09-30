//
//  FolderFile.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import Foundation
import FirebaseFirestore

struct FolderFile: FirestoreModel {
    var title: String = ""
    var description: String = ""
    var link: String = ""
    var imageUrl: String = ""
    var createdByUserId: String = ""
    var createdOn: String = ""
    
    init(id: String, docRef: DocumentReference, link: String, createdByUserId: String) {
        self.id = id
        self.docRef = docRef
        self.link = link
        self.createdByUserId = createdByUserId
    }
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var docRef: DocumentReference
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title,
            Constants.link: link,
            Constants.description: description,
            Constants.imageUrl: imageUrl,
            Constants.createdByUserId: createdByUserId,
            Constants.createdOn: createdOn
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let link = data[Constants.link] as? String
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.docRef = documentSnapshot.reference
        self.link = link
        self.title = data[Constants.title] as? String ?? ""
        self.description = data[Constants.description] as? String ?? ""
        self.imageUrl = data[Constants.imageUrl] as? String ?? ""
        self.createdByUserId = data[Constants.createdByUserId] as? String ?? ""
        self.createdOn = data[Constants.createdOn] as? String ?? ""
    }
    
    static func subcollectionRef(parentDocId: String) -> CollectionReference {
        return Firestore.firestore().collection(Constants.folders).document(parentDocId).collection(Constants.folderFiles)
    }
    
    static var collectionGroupQuery: Query {
        return Firestore.firestore().collectionGroup(Constants.folderFiles)
    }
}
