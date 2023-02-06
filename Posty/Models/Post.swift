//
//  Post.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String?
    let userId: Int
}

extension Array where Element == Post {
    
    static var mockData: [Post] {
        [
            .init(id: 1, title: "Post 1", body: "This is somebody 1", userId: 1),
            .init(id: 2, title: "Post 2", body: "This is somebody 2", userId: 2),
            .init(id: 3, title: "Post 3", body: "This is somebody 3. This is somebody 3. This is somebody 3. This is somebody 3. This is somebody 3. This is somebody 3", userId: 3),
            .init(id: 4, title: "Post 4", body: "This is somebody 4", userId: 4),
            .init(id: 5, title: "Post 5", body: "This is somebody 5", userId: 5)
        ]
    }
}
