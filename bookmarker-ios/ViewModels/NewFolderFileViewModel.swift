//
//  NewFolderFileViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import Foundation
import FirebaseAuth

class NewFolderFileViewModel: ObservableObject {
    @Published var link: String = ""
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    func create(folderId: String, completion: ((Error?) -> Void)?) {
        if link.isEmpty {
            return
        }
        
        guard let authUser = Auth.auth().currentUser else { return }
        
        isLoading = true
        
        let ref = FolderFile.subcollectionRef(parentDocId: folderId).document()
        let newFolderFile = FolderFile(id: ref.documentID, link: link, createdByUserId: authUser.uid)
        
        FolderFile.subcollectionRef(parentDocId: folderId).addDocument(data: newFolderFile.toDictionary) { (error) in
            self.isLoading = false 
            if let error = error {
                print("Error add folder file: \(error)")
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }
}
