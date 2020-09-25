//
//  SetFolderViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import Foundation
import FirebaseDynamicLinks

class SetFolderViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var secret: Bool = false
    @Published var isLoading: Bool = false
    
    func update(folderId: String, completion: ((Error?) -> Void)?) {
        isLoading = true
        
        Folder.collectionRef.document(folderId).updateData([
            Constants.title: title,
            Constants.description: description,
            Constants.secret: secret
        ]) { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error updating document: \(error)")
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }
}
