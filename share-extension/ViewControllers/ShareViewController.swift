//
//  ShareViewController.swift
//  share-extension
//
//  Created by Kenneth Ng on 9/16/20.
//

import UIKit
import Firebase

class ShareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        do {
            try Auth.auth().useUserAccessGroup("KDPC3776KJ.com.kennethlng.bookmarker.shared")
        } catch let error as NSError {
            print("Error changing user access group: %@, ", error)
        }
    }
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }

}
