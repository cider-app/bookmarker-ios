//
//  NewFileView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import SwiftUI

struct NewFileView: View {
    @State private var accountViewIsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.accountViewIsPresented = true
                        }) {
                            Image(systemName: Constants.Icon.account)
                        }
                    }
                }
        }
    }
}

struct NewFileView_Previews: PreviewProvider {
    static var previews: some View {
        NewFileView()
    }
}
