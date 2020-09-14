//
//  NewFolderFileViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import Foundation
import FirebaseAuth
import LinkPresentation

class NewFolderFileViewModel: ObservableObject {
    @Published var link: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var imageUrl: String = ""
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    @Published var metadata: LPLinkMetadata?
    @Published var error: String?
    @Published var editFolderFileViewIsPresented: Bool = false
    
    func create(folderId: String, completion: ((Error?) -> Void)?) {
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
    
    func fetchLinkMetadata() {
        let metadataProvider = LPMetadataProvider()
        let url = URL(string: link)!
        
        isLoading = true
        
        metadataProvider.startFetchingMetadata(for: url) { (metadata, error) in
            if error != nil {
                print("Error fetching metadata: \(error!)")
                return
            }
         
            guard let metadata = metadata else {
                print("No metadata found for link")
                return
            }
            
            DispatchQueue.main.async {
                self.metadata = metadata
                self.title = metadata.title ?? ""
                self.description = metadata.description
                self.editFolderFileViewIsPresented = true
                self.isLoading = false
            }
            
            if let imageProvider = metadata.imageProvider {
                imageProvider.loadObject(ofClass: UIImage.self) { (img, error) in
                    guard error == nil else { return }
                    
                    if let img = img as? UIImage {
                        DispatchQueue.main.async {
                            self.image = img
                        }
                    } else {
                        print("No image available")
                    }
                }
            }
        }
    }
    
    func reset() {
        self.link = ""
        self.title = ""
        self.description = ""
        self.imageUrl = ""
        self.image = nil
        self.metadata = nil
        self.error = nil
        self.isLoading = false
        self.editFolderFileViewIsPresented = false 
    }
}
