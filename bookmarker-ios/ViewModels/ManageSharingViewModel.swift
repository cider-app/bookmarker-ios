//
//  ManageSharingViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/15/20.
//

import Foundation
import FirebaseDynamicLinks
import FirebaseAuth

class ManageSharingViewModel: ObservableObject {
    @Published var permissions: Permissions = Permissions()
    @Published var shareLink: String = ""
    @Published var sharingIsEnabled: Bool = false
    @Published var secret: Bool = false
    @Published var isLoading: Bool = false
    @Published var linkSharingFooterMessage: String = ""
    @Published var permissionsFooterMessage: String = ""
    @Published var alertIsPresented: Bool = false
    
    func enableLinkSharing(folder: Folder) {
        //  If the VM is currently processing a request (i.e. disabling link sharing), then don't do anything and switch back the toggle
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        self.linkSharingFooterMessage = "Generating share link..."
        
        Helper.generateFolderShareLink(folder: folder) { (url) in
            if let url = url {
                Folder.collectionRef.document(folder.id).updateData([
                    Constants.sharingIsEnabled: true,
                    Constants.shareLink: url.absoluteString
                ]) { (error) in
                    if let error = error {
                        print("Error updating folder's link sharing settings: \(error)")
                        self.isLoading = false
                        self.linkSharingFooterMessage = "Unable to update link sharing settings. Try again later."
                        self.shareLink = ""
                        return
                    }
                    
                    //  When the folder document has been successfully updated with the new share link
                    self.sharingIsEnabled = true
                    self.isLoading = false
                    self.shareLink = url.absoluteString
                    self.linkSharingFooterMessage = ""
                }
            } else {
                self.isLoading = false
                self.shareLink = ""
                self.sharingIsEnabled = false
                self.linkSharingFooterMessage = "Oops! We encountered a problem when creating the link. Please try again."
            }
        }
    }
    
    func disableLinkSharing(folderId: String) {
        //  If the toggle is turned off while the VM is currently running a request (i.e. generating new share link), don't do anything and turn the toggle back on
        if isLoading {
            return
        }
        
        self.isLoading = true
        self.linkSharingFooterMessage = "Turning off link sharing..."
        
        //  Turn off link sharing (remove link share from folder document)
        Folder.collectionRef.document(folderId).updateData([
            Constants.sharingIsEnabled: false,
            Constants.shareLink: ""
        ]) { (error) in
            if let error = error {
                print("Error updating folder's link sharing settings: \(error)")
                self.linkSharingFooterMessage = "Unable to update link sharing settings. Try again later."
                self.sharingIsEnabled = true
                self.isLoading = false
                return
            }
            
            //  When the folder document has been successfully updated with the share link removed
            self.isLoading = false
            self.linkSharingFooterMessage = ""
            self.sharingIsEnabled = false 
            self.shareLink = ""
        }
    }
    
    func updatePermissions(folderId: String, completion: ((Error?) -> Void)?) {
        if isLoading {
            return
        }
        
        self.isLoading = true
        
        Folder.collectionRef.document(folderId).updateData([
            Constants.permissions: permissions.toDictionary
        ]) { (error) in
            self.isLoading = false
            
            if let error = error {
                print("Error updating permissions on folder document: \(error.localizedDescription)")
                self.permissionsFooterMessage = "Unable to update the permissions at this time"
                completion?(error)
                return
            }
            
            self.permissionsFooterMessage = "Permissions successfully updated!"
            completion?(nil)
        }
    }
}
