//
//  AccountPrivacyAndSecurityView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/19/20.
//

import SwiftUI

struct AccountPrivacyAndSecurityView: View {
    @State private var isOn: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Secret")) {
                HStack {
                    Spacer()
                    Toggle("", isOn: $isOn)
                    Spacer()
                }
            }
        }
        .navigationBarTitle("Privacy & Security", displayMode: .inline)
    }
}

struct AccountPrivacyAndSecurityView_Previews: PreviewProvider {
    static var previews: some View {
        AccountPrivacyAndSecurityView()
    }
}
