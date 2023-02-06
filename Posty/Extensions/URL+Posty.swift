//
//  URL+Posty.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

extension URL {
    
    /// API base url loaded from Info.plist
    static var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BASE_URL missing in Info.plist")
        }
        guard let url = URL(string: urlString) else {
            fatalError("Invalid BASE_URL")
        }
        return url
    }
}
