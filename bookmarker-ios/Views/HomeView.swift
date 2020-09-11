//
//  HomeView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var accountViewIsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            Text("Home")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.accountViewIsPresented = true
                        }) {
                            Image(systemName: Constants.Icon.account)
                        }
                    }
                }
                .sheet(isPresented: $accountViewIsPresented) {
                    AccountView(isPresented: $accountViewIsPresented)
                        .environmentObject(self.appState)
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
