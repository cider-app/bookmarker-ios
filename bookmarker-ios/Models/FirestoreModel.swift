//
//  FirestoreModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import FirebaseFirestore

protocol FirestoreModel: Identifiable, Hashable {
    var id: String { get set }
    var docRef: DocumentReference { get }
    var toDictionary: [String: Any] { get }
    init?(documentSnapshot: DocumentSnapshot)
}
