//
//  TabsView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

enum Tabs: Hashable {
    case home
    case newFile
    case notifications
}

struct TabsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        IfAuthenticatedView {
            TabView(selection: self.$appState.selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: Constants.Icon.home)
                    }
                    .tag(Tabs.home)
                NewFileView()
                    .tabItem {
                        Image(systemName: Constants.Icon.addFile)
                    }
                    .tag(Tabs.newFile)
                NotificationsView()
                    .tabItem {
                        Image(systemName: Constants.Icon.chat)
                    }
                    .tag(Tabs.notifications)
            }
            .onAppear {
                self.appState.listenCurrentUserFolders()
            }
            .onDisappear {
                self.appState.unlistenCurrentUserFolders()
            }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
