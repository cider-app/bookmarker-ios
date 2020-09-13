//
//  EditFolderViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import Foundation

class EditFolderViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var secret: Bool = false
    @Published var permissions: Permissions = Permissions()
    @Published var isLoading: Bool = false
    
    func update(folderId: String, completion: ((Error?) -> Void)?) {
        isLoading = true
        
        Folder.collectionRef.document(folderId).updateData([
            Constants.title: title,
            Constants.description: description,
            Constants.secret: secret,
            Constants.permissions: permissions.toDictionary
        ]) { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error updating document: \(error)")
                if completion != nil {
                    completion!(error)
                }
            } else {
                if completion != nil {
                    completion!(nil)
                }
            }
        }
    }
}
