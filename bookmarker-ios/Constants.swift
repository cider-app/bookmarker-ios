//
//  Constants.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation
import SwiftUI

struct Constants {
    static let title: String = "title"
    static let description: String = "description"
    static let secret: String = "secret"
    static let username: String = "username"
    static let folders: String = "folders"
    static let users: String = "users"
    static let folderUsers: String = "folder_users"
    static let folderFiles: String = "folder_files"
    static let userFolders: String = "user_folders"
    static let userId: String = "user_id"
    static let folderId: String = "folder_id"
    static let fileId: String = "file_id"
    static let cornerRadius: CGFloat = 16
    
    struct Icon {
        static let home: String = "house"
        static let messages: String = "message"
        static let close: String = "xmark"
        static let account: String = "person.crop.circle"
        static let more: String = "ellipsis"
        static let addFolder: String = "plus.rectangle.on.rectangle"
        static let addFile: String = "plus.app"
        static let add: String = "plus"
    }
}
