//
//  FolderViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import Foundation
import FirebaseFirestore

class FolderViewModel: ObservableObject {
    @Published var folder: Folder?
    @Published var folderFiles = [FolderFile]()
    var listener: ListenerRegistration?
    
    func listenFolder(folderId: String) {
        listener = Folder.collectionRef.document(folderId).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            if let folder = Folder(documentSnapshot: document) {
                self.folder = folder
            }
        }
    }
    
    func listenFolderFiles(folderId: String) {
        FolderFile.subcollectionRef(parentDocId: folderId).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let items = documents.compactMap {
                FolderFile(documentSnapshot: $0)
            }
            self.folderFiles = items
        }
    }
    
    func unlistenFolder() {
        listener?.remove()
    }
}
