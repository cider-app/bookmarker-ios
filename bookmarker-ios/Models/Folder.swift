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
    var permissions: Permissions = Permissions()
    var createdByUserId: String = ""
    
    init(id: String, title: String, description: String, secret: Bool = true, permissions: Permissions = Permissions(), createdByUserId: String) {
        self.id = id
        self.title = title
        self.description = description
        self.secret = secret
        self.permissions = permissions
        self.createdByUserId = createdByUserId
    }
    
    //  MARK: - FirestoreModel protocol
    var id: String
    
    var toDictionary: [String : Any] {
        return [
            Constants.title: title,
            Constants.description: description,
            Constants.secret: secret,
            Constants.permissions: permissions.toDictionary,
            Constants.createdByUserId: createdByUserId
        ]
    }
    
    init?(documentSnapshot: DocumentSnapshot) {
        guard let data = documentSnapshot.data(),
              let title = data[Constants.title] as? String
        else { return nil }
        
        let permissionsData = data[Constants.permissions] as? [String: Bool]
        
        self.id = documentSnapshot.documentID
        self.title = title
        self.description = data[Constants.description] as? String ?? ""
        self.secret = data[Constants.secret] as? Bool ?? true 
        self.permissions = Permissions(data: permissionsData)
        self.createdByUserId = data[Constants.createdByUserId] as? String ?? ""
    }
    
    static var collectionRef: CollectionReference {
        return Firestore.firestore().collection(Constants.folders)
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        let isEqual = lhs.id == rhs.id
        return isEqual
    }
}
