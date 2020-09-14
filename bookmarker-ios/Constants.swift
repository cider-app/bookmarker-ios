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
    static let link: String = "link"
    static let imageUrl: String = "image_url"
    static let favicon: String = "favicon"
    static let permissions: String = "permissions"
    static let canEdit: String = "can_edit"
    static let canManageMembers: String = "can_manage_members"
    static let createdByUserId: String = "created_by_user_id"
    static let verticalSpacing: CGFloat = 16
    static let createdOn: String = "created_on"
    static let modifiedOn: String = "modified_on"
    
    struct Icon {
        static let home: String = "house"
        static let messages: String = "message"
        static let close: String = "xmark"
        static let account: String = "person.crop.circle"
        static let more: String = "ellipsis"
        static let addFolder: String = "plus.rectangle.on.rectangle"
        static let addFile: String = "plus.app"
        static let add: String = "plus"
        static let edit: String = "pencil"
        static let members: String = "person.2"
        static let leave: String = "arrow.left.to.line"
        static let delete: String = "trash"
        static let chat: String = "message"
        static let share: String = "square.and.arrow.up"
        static let folders: String = "rectangle.grid.1x2" //"rectangle.on.rectangle.angled"
    }
}
