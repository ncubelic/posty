//
//  Comment.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
