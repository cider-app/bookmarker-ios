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
    static let emoji: String = "emoji"
    static let color: String = "color"
    static let cornerRadius: CGFloat = 20
    static let link: String = "link"
    static let imageUrl: String = "image_url"
    static let favicon: String = "favicon"
    static let permissions: String = "permissions"
    static let sharingIsEnabled: String = "sharing_is_enabled"
    static let canEdit: String = "can_edit"
    static let canManageMembers: String = "can_manage_members"
    static let createdByUserId: String = "created_by_user_id"
    static let shareLink: String = "share_link"
    static let verticalSpacing: CGFloat = 16
    static let createdOn: String = "created_on"
    static let modifiedOn: String = "modified_on"
    static let folderFilesListRowViewSize: CGFloat = 100
    static let dynamicLinksDomainURIPrefix: String = "https://bookmarker.page.link"
    static let webUrl: String = "bookmarker-996f8.web.app"
    static let collectionsPath: String = "/collections"
    static let appStoreId: String = "1504978096"
    static let appName: String = "Cider"
    static let recentlyCreatedFolderFilesGridWidth: CGFloat = 100
    static let recentlyCreatedFolderFilesGridHeight: CGFloat = 150
    static let fontWeight: Font.Weight = .heavy
    static let iconFontTextStyle: Font.TextStyle = .title3
    static let iconPrimaryButtonShadow: CGFloat = 4
    static let sectionHeaderFontTextStyle: Font.TextStyle = .subheadline
    static let logoFontTextStyle: Font.TextStyle = .title
    static let defaultFolderEmoji: String = "🥳"
    static let defaultFolderColor: String = "#FF93E0"
    static let buttonPressedSaturation: Double = 0.5
    
    struct Icon {
        static let home: String = "house"
        static let messages: String = "message"
        static let close: String = "xmark"
        static let account: String = "person.crop.circle.fill"
        static let more: String = "ellipsis"
        static let addFolder: String = "rectangle.badge.plus"
        static let addFile: String = "plus.app"
        static let add: String = "plus"
        static let edit: String = "pencil"
        static let members: String = "person.2"
        static let leave: String = "arrow.left.to.line"
        static let delete: String = "trash"
        static let chat: String = "message"
        static let share: String = "square.and.arrow.up"
        static let folders: String = "rectangle.grid.1x2" //"rectangle.on.rectangle.angled"
        static let back: String = "chevron.left"
        static let write: String = "square.and.pencil"
        static let security: String = "checkmark.shield.fill"
        static let notifications: String = "app.badge.fill"
        static let support: String = "questionmark.circle.fill"
        static let compactForward: String = "chevron.compact.right"
        static let arrowLeft: String = "arrow.left"
        static let arrowRight: String = "arrow.right"
    }
    
    struct Path {
        static let collections: String = "collections"
    }
}
