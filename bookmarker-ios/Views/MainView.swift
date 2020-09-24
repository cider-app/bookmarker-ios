//
//  MainView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/13/20.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            HomeView()
                .onAppear {
                    self.appState.listenCurrentUserFolders()
                }
                .onDisappear {
                    self.appState.unlistenCurrentUserFolders()
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
