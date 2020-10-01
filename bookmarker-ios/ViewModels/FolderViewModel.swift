//
//  FolderViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import LinkPresentation

class FolderViewModel: ObservableObject {
    @Published var folder: Folder?
    @Published var folderFiles = [FolderFile]()
    @Published var newLink: String = ""
    @Published var isLoading: Bool = false
    @Published var currentUserIsMember: Bool = false
    @Published var shareLinkMetadata: LPLinkMetadata?
    var folderListener: ListenerRegistration?
    var folderFilesListener: ListenerRegistration?
    
    func listenFolder(folderId: String) {
        folderListener = Folder.collectionRef.document(folderId).addSnapshotListener { (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            if let folder = Folder(documentSnapshot: document) {
                self.folder = folder
                self.fetchShareLinkMetadata(urlString: "https://developer.apple.com/documentation/linkpresentation/lpmetadataprovider")
            }
        }
    }
    
    func listenFolderFiles(folderId: String) {
        folderFilesListener = FolderFile.subcollectionRef(parentDocId: folderId).addSnapshotListener { (querySnapshot, error) in
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
        folderListener?.remove()
    }
    
    func unlistenFolderFiles() {
        folderFilesListener?.remove()
    }
    
    func leave(folderId: String, completion: ((Error?) -> Void)?) {
        guard let authUser = Auth.auth().currentUser else { return }
        
        isLoading = true
        
        let batch = Firestore.firestore().batch()
        
        let userFolderRef = UserFolder.subcollectionRef(parentDocId: authUser.uid).document(folderId)
        let folderUserRef = FolderUser.subcollectionRef(parentDocId: folderId).document(authUser.uid)
        
        batch.deleteDocument(userFolderRef)
        batch.deleteDocument(folderUserRef)
        
        batch.commit { (error) in
            self.isLoading = false
            if let error = error {
                print("Error removing document: \(error)")
                completion?(error)
            } else {
                print("User folder successfully removed!")
                completion?(nil)
            }
        }
    }
    
    func delete(folderId: String, completion: ((Error?) -> Void)?) {
        isLoading = true
        Folder.collectionRef.document(folderId).delete { (error) in
            self.isLoading = false
            if let error = error {
                print("Error removing document: \(error)")
                completion?(error)
            } else {
                print("User folder successfully removed!")
                completion?(nil)
            }
        }
    }
    
    func getCurrentUserMembership(folderId: String) {
        guard let authUser = Auth.auth().currentUser else { return }
        
        FolderUser.subcollectionRef(parentDocId: folderId).document(authUser.uid).getDocument { (documentSnapshot, error) in
            if let document = documentSnapshot, document.exists {
                self.currentUserIsMember = true
            } else {
                print("Document does not exist")
                self.currentUserIsMember = false 
            }
        }
    }
    
    func fetchShareLinkMetadata(urlString: String) {
        let metadataProvider = LPMetadataProvider()
        let url = URL(string: urlString)!
        
        metadataProvider.startFetchingMetadata(for: url) { (metadata, error) in
            if error != nil {
                print("Error fetching metadata: \(error!)")
                self.shareLinkMetadata = nil
                return
            }
         
            guard let metadata = metadata else { return }
            
            DispatchQueue.main.async {
                self.shareLinkMetadata = metadata
            }
        }
    }
    
    func addLink(folderId: String, completion: ((Error?) -> Void)?) {
        if isLoading {
            return
        }
        
        guard let authUser = Auth.auth().currentUser else { return }
        
        isLoading = true
        
        let subcollectionRef = FolderFile.subcollectionRef(parentDocId: folderId)
        let docRef = subcollectionRef.document()
        let newFolderFile = FolderFile(id: docRef.documentID, docRef: docRef, link: newLink, createdByUserId: authUser.uid)
        
        subcollectionRef.addDocument(data: newFolderFile.toDictionary) { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error creating new folderFile document: \(error.localizedDescription)")
                completion?(error)
                return
            }
            
            self.newLink = ""
            completion?(nil)
        }
    }
}
