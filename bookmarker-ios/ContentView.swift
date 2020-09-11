//
//  ContentView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                self.appState.listenAuth()
            }
            .onDisappear {
                self.appState.unlistenAuth()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
