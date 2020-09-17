//
//  FirestoreModel.swift
//  share-extension
//
//  Created by Kenneth Ng on 9/16/20.
//

import Foundation
import FirebaseFirestore

protocol FirestoreModel: Identifiable, Hashable {
    var id: String { get set }
    var toDictionary: [String: Any] { get }
    init?(documentSnapshot: DocumentSnapshot)
}
