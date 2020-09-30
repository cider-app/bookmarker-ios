//
//  MembersListRowViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import Foundation
import FirebaseFirestore

class MembersListRowViewModel: ObservableObject {
    func delete(docRef: DocumentReference) {
        docRef.delete { (error) in
            if let error = error {
                print("Error deleting member document: \(error.localizedDescription)")
                return
            }
        }
    }
}
