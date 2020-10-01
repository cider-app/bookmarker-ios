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
    var secret: Bool = true
    var permissions: Permissions = Permissions()
    var createdByUserId: String = ""
    var shareLink: String = ""
    var emoji: String = Constants.defaultFolderEmoji
    var sharingIsEnabled: Bool = false
    
    init(id: String, title: String, secret: Bool = true, emoji: String, createdByUserId: String) {
        self.id = id
        self.docRef = Firestore.firestore().collection(Constants.folders).document(id)
        self.title = title
        self.emoji = emoji
        self.secret = secret
        self.createdByUserId = createdByUserId
    }
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var docRef: DocumentReference
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title,
            Constants.secret: secret,
            Constants.permissions: permissions.toDictionary,
            Constants.createdByUserId: createdByUserId,
            Constants.shareLink: shareLink,
            Constants.emoji: emoji,
            Constants.sharingIsEnabled: sharingIsEnabled
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let title = data[Constants.title] as? String
        else { return nil }
        
        let permissionsData = data[Constants.permissions] as? [String: Bool]
        
        self.id = documentSnapshot.documentID
        self.docRef = documentSnapshot.reference
        self.title = title
        self.secret = data[Constants.secret] as? Bool ?? true 
        self.permissions = Permissions(data: permissionsData)
        self.createdByUserId = data[Constants.createdByUserId] as? String ?? ""
        self.shareLink = data[Constants.shareLink] as? String ?? ""
        self.emoji = data[Constants.emoji] as? String ?? Constants.defaultFolderEmoji
        self.sharingIsEnabled = data[Constants.sharingIsEnabled] as? Bool ?? false
    }
    
    static var collectionRef: CollectionReference {
        return Firestore.firestore().collection(Constants.folders)
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        let isEqual = lhs.id == rhs.id
        return isEqual
    }
}
