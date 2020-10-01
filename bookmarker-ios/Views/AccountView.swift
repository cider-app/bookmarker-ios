//
//  AccountView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ProtectedWithPlaceholderView {
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: Constants.Icon.close)
                            }
                            .buttonStyle(CustomButtonStyle(variant: .contained, color: .secondary, fullWidth: false))
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text("Account")
                                .modifier(NavigationTitleViewModifier())
                            
                            Spacer()
                        }
                    }
                    .modifier(NavigationBarViewModifier())
                    
                    ScrollView {
                        VStack {
                            if let authUser = self.appState.authUser {
                                Section {
                                    Text(authUser.uid)
                                }
                            }
                            Section(
                                header:
                                    Text("")
                                        .modifier(SectionHeaderViewModifier())
                            ) {
                                NavigationLink(destination: AccountPrivacyAndSecurityView()) {
                                    HStack {
                                        LabelView(text: "Privacy & Security", systemName: Constants.Icon.security)
                                            .foregroundColor(Color.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: Constants.Icon.compactForward)
                                            .foregroundColor(Color(.quaternaryLabel))
                                            .padding(.horizontal)
                                    }
                                    .font(Font.system(.headline).weight(.semibold))
                                    .padding(.vertical)
                                }
                                
                                NavigationLink(destination: AccountPrivacyAndSecurityView()) {
                                    HStack {
                                        LabelView(text: "Notifications", systemName: Constants.Icon.notifications)
                                            .foregroundColor(Color.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: Constants.Icon.compactForward)
                                            .foregroundColor(Color(.quaternaryLabel))
                                            .padding(.horizontal)
                                    }
                                    .font(Font.system(.headline).weight(.semibold))
                                    .padding(.vertical)
                                }
                                
                                NavigationLink(destination: AccountPrivacyAndSecurityView()) {
                                    HStack {
                                        LabelView(text: "Support", systemName: Constants.Icon.support)
                                            .foregroundColor(Color.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: Constants.Icon.compactForward)
                                            .foregroundColor(Color(.quaternaryLabel))
                                            .padding(.horizontal)
                                    }
                                    .font(Font.system(.headline).weight(.semibold))
                                    .padding(.vertical)
                                }
                            }
                            Section(header:
                                Text("")
                                    .modifier(SectionHeaderViewModifier())
                            ) {
                                Button(action: {
                                    self.appState.signOut { (error) in
                                        if error == nil {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                }) {
                                    Text("Sign out")
                                }
                                .buttonStyle(CustomButtonStyle(variant: .contained, color: .primary, fullWidth: true, alignment: .center))
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
