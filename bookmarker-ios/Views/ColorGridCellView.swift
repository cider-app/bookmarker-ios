//
//  ColorGridCellView.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/23/20.
//

import SwiftUI

struct ColorGridCellView: View {
    var color: Color
    
    var body: some View {
        color
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 4)
    }
}

//struct ColorGridCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorGridCellView()
//    }
//}
