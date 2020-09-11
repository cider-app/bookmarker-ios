//
//  AuthenticationView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Text("Authentication")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            self.isPresented = false
                        }) {
                            Image(systemName: Constants.Icon.close)
                        }
                    }
                }
        }
    }
}

//struct AuthenticationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticationView()
//    }
//}
