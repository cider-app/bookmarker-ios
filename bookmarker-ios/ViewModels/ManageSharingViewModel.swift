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
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.webUrl
        components.path = Constants.collectionsPath
        components.path.append("/\(folder.id)")
        guard let link = components.url else {
            print("Could not create web url")
            self.isLoading = false
            self.sharingIsEnabled = false
            self.shareLink = ""
            self.linkSharingFooterMessage = "Oops! We encountered a problem when creating the link. Please try again."
            return
        }
          
        //  Create dynamic link
        guard let shareLinkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: Constants.dynamicLinksDomainURIPrefix) else {
            print("Could not create Firebase Dynamic Links component")
            self.isLoading = false
            self.shareLink = ""
            self.sharingIsEnabled = false
            self.linkSharingFooterMessage = "Oops! We encountered a problem when creating the link. Please try again."
            return
        }
        
        if let iOSBundleId = Bundle.main.bundleIdentifier {
            shareLinkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: iOSBundleId)
        }
        shareLinkBuilder.iOSParameters?.appStoreID = Constants.appStoreId
        shareLinkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        shareLinkBuilder.socialMetaTagParameters?.title = "\(folder.title) on \(Constants.appName)"
//        shareLinkBuilder.socialMetaTagParameters?.imageURL =
        
        //  Create short Firebase Dynamic Link
        shareLinkBuilder.shorten { (url, warnings, error) in
            if let error = error {
                print("Error creating short dynamic link: \(error)")
                self.isLoading = false
                self.sharingIsEnabled = false
                self.shareLink = ""
                self.linkSharingFooterMessage = "Oops! We encountered a problem when creating the link. Please try again."
                return
            }
            
            if let warnings = warnings {
                for warning in warnings {
                    print("Firebase dynamic link warning: \(warning)")
                }
            }
            
            guard let url = url else {
                self.isLoading = false
                self.sharingIsEnabled = false
                self.shareLink = ""
                self.linkSharingFooterMessage = "Oops! We encountered a problem when creating the link. Please try again."
                return
            }
            
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
