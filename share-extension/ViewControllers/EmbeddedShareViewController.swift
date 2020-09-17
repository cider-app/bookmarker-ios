//
//  EmbeddedShareViewController.swift
//  share-extension
//
//  Created by Kenneth Ng on 9/16/20.
//

import UIKit
import Social
import MobileCoreServices
import FirebaseFirestore
import FirebaseAuth

class EmbeddedShareViewController: UIViewController, CurrentUserFoldersTableDelegate {

    var url: String?
    var currentUserFoldersTable: CurrentUserFoldersTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let item = self.extensionContext?.inputItems.first as? NSExtensionItem {
            accessWebpageProperties(extensionItem: item) { (item, error) in
                guard let dictionary = item as? NSDictionary,
                    let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                    let title = results["title"] as? String,
                    let url = results["url"] as? String
                else { return }
                
                self.url = url
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.completeRequest()
    }
    
    /**
     Here, we iterate over the attachments if there are any and then filter those who conform to the kUTTypePropertyList type identifier. After that, we load the item’s data, parse it and using the key NSExtensionJavaScript PreprocessingResultsKey we retrieve the object passed on the completionFunction in the JavaScript code
     */
    private func accessWebpageProperties(extensionItem: NSExtensionItem, handler: @escaping NSItemProvider.CompletionHandler) {
        let contentType = kUTTypePropertyList as String
        
        for attachment in extensionItem.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                attachment.loadItem(forTypeIdentifier: contentType, options: nil, completionHandler: handler)
            }
        }
    }
    
    func completeRequest() {
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    // MARK: - CurrentUserFoldersTableDelegate
    func select(selectedUserFolder: UserFolder) {
        guard let url = self.url, let authUser = Auth.auth().currentUser else { return }
        
        let collectionRef = FolderFile.subcollectionRef(parentDocId: selectedUserFolder.id)
        let docRef = collectionRef.document()
        let newDoc = FolderFile(id: docRef.documentID, link: url, createdByUserId: authUser.uid)
        
        docRef.setData(newDoc.toDictionary) { (error) in
            if let error = error {
                print("Error creating new folder file document: \(error)")
                return
            }
            
            self.completeRequest()
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "currentUserFoldersTableSegue" {
            currentUserFoldersTable = segue.destination as? CurrentUserFoldersTableViewController
            currentUserFoldersTable?.delegate = self
        }
    }
}
