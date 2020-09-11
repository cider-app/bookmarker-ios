//
//  TabsView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        HomeView()
            .tabItem {
                Image(systemName: Constants.Icon.home)
            }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
