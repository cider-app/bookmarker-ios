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
    @Published var linkSharingToggleIsOn: Bool = false
    @Published var permissions: Permissions = Permissions()
    @Published var shareLink: String = ""
    @Published var isLoading: Bool = false
    @Published var isProcessingLinkSharingRequest: Bool = false
    @Published var linkSharingFooterMessage: String = ""
    
    func toggleLinkSharing(folder: Folder) {
        //  If toggle is enabled and link sharing isn't enabled yet, generate the share link.
        if self.linkSharingToggleIsOn && self.shareLink.isEmpty {
            self.enableLinkSharing(folder: folder)
        }
        //  Else if the toggle is off and share linking is already enabled
        else if !self.linkSharingToggleIsOn && !self.shareLink.isEmpty  {
            self.disableLinkSharing(folderId: folder.id)
        }
    }
    
    func enableLinkSharing(folder: Folder) {
        //  If the VM is currently processing a request (i.e. disabling link sharing), then don't do anything and switch back the toggle
        if self.isProcessingLinkSharingRequest {
            return
        }
        
        self.isProcessingLinkSharingRequest = true
        self.linkSharingFooterMessage = "Generating share link..."
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.webUrl
        components.path = Constants.collectionsPath
        components.path.append("/\(folder.id)")
        guard let link = components.url else {
            print("Could not create web url")
            self.isProcessingLinkSharingRequest = false
            self.linkSharingToggleIsOn = false
            self.shareLink = ""
            return
        }
          
        //  Create dynamic link
        guard let shareLinkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: Constants.dynamicLinksDomainURIPrefix) else {
            print("Could not create Firebase Dynamic Links component")
            self.isProcessingLinkSharingRequest = false
            self.linkSharingToggleIsOn = false
            self.shareLink = ""
            return
        }
        
        if let iOSBundleId = Bundle.main.bundleIdentifier {
            shareLinkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: iOSBundleId)
        }
        shareLinkBuilder.iOSParameters?.appStoreID = Constants.appStoreId
        shareLinkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        shareLinkBuilder.socialMetaTagParameters?.title = "\(folder.title) on \(Constants.appName)"
        shareLinkBuilder.socialMetaTagParameters?.descriptionText = folder.description
//        shareLinkBuilder.socialMetaTagParameters?.imageURL =
        
        //  Create short Firebase Dynamic Link
        shareLinkBuilder.shorten { (url, warnings, error) in
            if let error = error {
                print("Error creating short dynamic link: \(error)")
                self.isProcessingLinkSharingRequest = false
                self.linkSharingToggleIsOn = false
                self.shareLink = ""
                return
            }
            
            if let warnings = warnings {
                for warning in warnings {
                    print("Firebase dynamic link warning: \(warning)")
                }
            }
            
            guard let url = url else {
                self.isProcessingLinkSharingRequest = false
                self.linkSharingToggleIsOn = false
                self.shareLink = ""
                return
            }
            
            Folder.collectionRef.document(folder.id).updateData([
                Constants.shareLink: url.absoluteString
            ]) { (error) in
                if let error = error {
                    print("Error updating folder's link sharing settings: \(error)")
                    self.isProcessingLinkSharingRequest = false
                    self.linkSharingFooterMessage = "Unable to update link sharing settings. Try again later."
                    self.linkSharingToggleIsOn = false
                    self.shareLink = ""
                    return
                }
                
                //  When the folder document has been successfully updated with the new share link
                self.isProcessingLinkSharingRequest = false
                self.shareLink = url.absoluteString
                self.linkSharingFooterMessage = ""
            }
        }
    }
    
    func disableLinkSharing(folderId: String) {
        //  If the toggle is turned off while the VM is currently running a request (i.e. generating new share link), don't do anything and turn the toggle back on
        if isProcessingLinkSharingRequest {
            return
        }
        
        self.isProcessingLinkSharingRequest = true
        self.linkSharingFooterMessage = "Turning off link sharing..."
        
        //  Turn off link sharing (remove link share from folder document)
        Folder.collectionRef.document(folderId).updateData([
            Constants.shareLink: ""
        ]) { (error) in
            if let error = error {
                print("Error updating folder's link sharing settings: \(error)")
                self.linkSharingFooterMessage = "Unable to update link sharing settings. Try again later."
                self.linkSharingToggleIsOn = true
                self.isProcessingLinkSharingRequest = false
                return
            }
            
            //  When the folder document has been successfully updated with the share link removed
            self.isProcessingLinkSharingRequest = false
            self.linkSharingFooterMessage = ""
            self.shareLink = ""
        }
    }
}
