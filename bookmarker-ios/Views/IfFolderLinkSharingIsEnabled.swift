//
//  IfFolderLinkSharingIsEnabled.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/14/20.
//

import SwiftUI

struct IfFolderLinkSharingIsEnabled<Content: View>: View {
    var folder: Folder?
    let content: Content
    
    init(folder: Folder?, @ViewBuilder content: @escaping () -> Content) {
        self.folder = folder
        self.content = content()
    }
    
    var body: some View {
        Group {
            if let folder = self.folder, !folder.shareLink.isEmpty {
                content
            }
        }
    }
}

//struct IfFolderLinkSharingIsEnabled_Previews: PreviewProvider {
//    static var previews: some View {
//        IfFolderLinkSharingIsEnabled()
//    }
//}
