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
    var secret: Bool = true
    var emoji: String = Constants.defaultFolderEmoji
    var color: String = Constants.defaultFolderColor
    
    init(id: String, docRef: DocumentReference, title: String, description: String, secret: Bool, emoji: String, color: String) {
        self.id = id
        self.docRef = docRef
        self.title = title
        self.description = description
        self.secret = secret
        self.emoji = emoji
        self.color = color
    }
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var docRef: DocumentReference
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title,
            Constants.description: description,
            Constants.secret: secret,
            Constants.folderId: id,
            Constants.emoji: emoji,
            Constants.color: color
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let title = data[Constants.title] as? String
        else { return nil }
        
        self.id = documentSnapshot.documentID
        self.docRef = documentSnapshot.reference
        self.title = title
        self.description = data[Constants.description] as? String ?? ""
        self.secret = data[Constants.secret] as? Bool ?? true
        self.emoji = data[Constants.emoji] as? String ?? Constants.defaultFolderEmoji
        self.color = data[Constants.color] as? String ?? Constants.defaultFolderColor
    }
    
    static func subcollectionRef(parentDocId: String) -> CollectionReference {
        return Firestore.firestore().collection(Constants.users).document(parentDocId).collection(Constants.userFolders)
    }
    
    static func == (lhs: UserFolder, rhs: UserFolder) -> Bool {
        let isEqual = lhs.id == rhs.id
        return isEqual
    }
}
