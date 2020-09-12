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
            IfAuthenticatedView {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("My Collections")
                            Spacer()
                            Button(action: {
                                
                            }) {
                                Image(systemName: Constants.Icon.addFolder)
                            }
                        }
                        ForEach(self.vm.userFolders, id: \.id) { userFolder in
                            UserFoldersListRowView(userFolder: userFolder)
                        }
                    }
                    .padding()
                }
                .onAppear {
                    self.vm.listen(userId: self.appState.authUser!.uid)
                }
                .onDisappear {
                    self.vm.unlisten()
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
