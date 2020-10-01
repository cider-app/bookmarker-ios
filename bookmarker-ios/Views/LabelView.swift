//
//  LabelView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/30/20.
//

import SwiftUI

struct LabelView: View {
    var text: String
    var systemName: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .frame(width: 20)
                .padding(.horizontal)
            Text(text)
        }
    }
}

//struct LabelView_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelView()
//    }
//}
