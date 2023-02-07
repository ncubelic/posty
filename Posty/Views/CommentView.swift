//
//  CommentView.swift
//  Posty
//
//  Created by Nikola Čubelić on 07.02.2023..
//

import SwiftUI

struct CommentView: View {
    
    private let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(comment.email + ":")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Text(comment.body)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: .init(postId: 1, id: 1, name: "", email: "", body: ""))
    }
}
