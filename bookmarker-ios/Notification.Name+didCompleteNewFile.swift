//
//  Notification.Name+didCompleteNewFile.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/11/20.
//

import Foundation

extension Notification.Name {
    static var didCompleteNewFile: Notification.Name {
        return Notification.Name("did complete new file")
    }
}
