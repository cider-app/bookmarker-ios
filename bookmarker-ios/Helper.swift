//
//  Helper.swift
//  bookmarker-ios
//
//  Created by Kenneth Ng on 9/25/20.
//

import Foundation
import UIKit
import FirebaseDynamicLinks

class Helper {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func generateFolderShareLink(folder: Folder, completion: ((URL?) -> Void)?) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.webUrl
        components.path = Constants.collectionsPath
        components.path.append("/\(folder.id)")
        guard let link = components.url else {
            print("Could not create web url")
            completion?(nil)
            return
        }
          
        //  Create dynamic link
        guard let shareLinkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: Constants.dynamicLinksDomainURIPrefix) else {
            print("Could not create Firebase Dynamic Links component")
            completion?(nil)
            return
        }
        
        if let iOSBundleId = Bundle.main.bundleIdentifier {
            shareLinkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: iOSBundleId)
        }
        shareLinkBuilder.iOSParameters?.appStoreID = Constants.appStoreId
        shareLinkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        shareLinkBuilder.socialMetaTagParameters?.title = "\(folder.title) on \(Constants.appName)"
//        shareLinkBuilder.socialMetaTagParameters?.imageURL =
        
        //  Create short Firebase Dynamic Link
        shareLinkBuilder.shorten { (url, warnings, error) in
            if let error = error {
                print("Error creating short dynamic link: \(error)")
                completion?(nil)
                return
            }
            
            if let warnings = warnings {
                for warning in warnings {
                    print("Firebase dynamic link warning: \(warning)")
                }
            }
            
            guard let url = url else {
                completion?(nil)
                return
            }
            
            completion?(url)
        }
    }
}
