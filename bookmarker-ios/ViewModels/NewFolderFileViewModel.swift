//
//  NewFolderFileViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import Foundation

class NewFolderFileViewModel: ObservableObject {
    @Published var link: String = ""
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    func create(folderId: String, completion: ((Error?) -> Void)?) {
        if link.isEmpty {
            return
        }
        
        isLoading = true
        
        let ref = FolderFile.subcollectionRef(parentDocId: folderId).document()
        let newFolderFile = FolderFile(id: ref.documentID, link: link)
        
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
