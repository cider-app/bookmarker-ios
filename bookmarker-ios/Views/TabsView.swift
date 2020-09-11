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
}

struct TabsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
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
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
