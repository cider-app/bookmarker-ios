//
//  Permissions.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/12/20.
//

import Foundation

struct Permissions: Hashable {
    var canEdit: Bool = false
    var canManageMembers: Bool = false
    
    var toDictionary: [String : Bool] {
        return [
            Constants.canEdit: canEdit,
            Constants.canManageMembers: canManageMembers
        ]
    }
    
    init() {
        self.canEdit = false
        self.canManageMembers = false
    }
    
    init(data: [String: Bool]?) {
        self.canEdit = data?[Constants.canEdit] ?? false
        self.canManageMembers = data?[Constants.canManageMembers] ?? false
    }
}
