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
    var link: String = ""
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title,
            Constants.link: link
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let link = data[Constants.link] as? String
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.link = link
        self.title = data[Constants.title] as? String ?? ""
    }
    
    static func subcollectionRef(parentDocId: String) -> CollectionReference {
        return Firestore.firestore().collection(Constants.folders).document(parentDocId).collection(Constants.folderFiles)
    }
}
