//
//  CommentsViewModel.swift
//  Posty
//
//  Created by Nikola Čubelić on 07.02.2023..
//

import Foundation

struct CommentsViewModel {
    
    private var comments: [Comment] = []
    private var isExpanded = false
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
    func comment(index: Int) -> Comment {
        comments[index]
    }
    
    func numberOfComments() -> Int {
        comments.count
    }
    
    func lastComments(count: Int) -> [Comment] {
        guard count <= comments.count else { return [] }
        guard count >= 0 else { return [] }
        
        return Array(comments.prefix(count))
    }
}
