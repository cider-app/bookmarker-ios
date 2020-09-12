//
//  HomeView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI
import FirebaseFirestore

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var accountViewIsPresented: Bool = false
    @StateObject var vm = UserFoldersViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                //  First let auth perform the initial check to see if a user is signed in or not
                if self.appState.authStateFirstChanged {
                    if let authUser = self.appState.authUser {
                        ScrollView {
                            VStack {
                                HStack {
                                    Text("My Collections")
                                    Spacer()
                                    Button(action: {
                                        
                                    }) {
                                        Image(systemName: Constants.Icon.addFolder)
                                    }
                                }
                                ForEach(self.vm.userFolders, id: \.id) { userFolder in
                                    Text(userFolder.title)
                                }
                            }
                            .padding()
                        }
                        .onAppear {
                            self.vm.listen(userId: authUser.uid)
                        }
                        .onDisappear {
                            self.vm.unlisten()
                        }
                    } else {
                        Color(.systemBackground)
                        .onAppear {
                            self.appState.signInAnonymously()
                        }
                    }
                } else {
                    Color(.systemBackground)
                }
            }
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
