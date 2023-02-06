//
//  Endpoint.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

enum Endpoint: URLConvertible {
    
    case posts
    case users
    case comments
    
    func urlString() -> String {
        switch self {
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .comments:
            return "/comments"
        }
    }
}
