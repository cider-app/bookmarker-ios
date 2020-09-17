//
//  CurrentUserFoldersTableViewController.swift
//  share-extension
//
//  Created by Kenneth Ng on 9/16/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol CurrentUserFoldersTableDelegate {
    func select(selectedUserFolder: UserFolder)
}

class CurrentUserFoldersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var delegate: CurrentUserFoldersTableDelegate?
    var userFolders = [UserFolder]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let authUser = Auth.auth().currentUser else { return }
        UserFolder.subcollectionRef(parentDocId: authUser.uid).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error retrieving user_folder documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else { return }
            
            let items = documents.compactMap {
                UserFolder(documentSnapshot: $0)
            }
            self.userFolders = items
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userFolders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        let userFolder = userFolders[row]

        // Configure the cell...
        cell.textLabel?.text = userFolder.title
        cell.detailTextLabel?.text = userFolder.description

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let userFolder = userFolders[row]
        delegate?.select(selectedUserFolder: userFolder)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
