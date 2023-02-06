//
//  PostViewModel.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

struct PostViewModel {
    var post: Post?
    var author: User?
    var comments: [Comment] = []
}
