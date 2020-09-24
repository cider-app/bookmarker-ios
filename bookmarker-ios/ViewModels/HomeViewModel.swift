//
//  HomeViewModel.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/17/20.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var sheetIsPresented: Bool = false
    @Published var activeSheet: HomeSheet = .account
    @Published var deepLinkFolderNavLinkIsActive: Bool = false
    @Published var deepLinkFolderNavLinkId: String = ""
    
    enum HomeSheet {
        case add, account, newFolder
    }
    
    func handleOpenedUrl(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }

        if let queryItems = components.queryItems {
            if let linkIndex = queryItems.firstIndex(where: { $0.name == Constants.link }),
               let link = queryItems[linkIndex].value,
               let linkUrl = URL(string: link) {
                guard linkUrl.pathComponents.count >= 3 else { return }
                let section = linkUrl.pathComponents[1]
                let detail = linkUrl.pathComponents[2]
                
                switch section {
                case Constants.Path.collections:
                    self.deepLinkFolderNavLinkId = detail
                    self.deepLinkFolderNavLinkIsActive = true
                default:
                    break
                }
            }
        }
    }
}
