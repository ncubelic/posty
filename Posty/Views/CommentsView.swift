//
//  CommentsView.swift
//  Posty
//
//  Created by Nikola Čubelić on 07.02.2023..
//

import SwiftUI

struct CommentsView: View {
    
    private let viewModel: CommentsViewModel
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            DisclosureGroup("Comments (\(viewModel.numberOfComments()))") {
                ForEach(0..<viewModel.numberOfComments(), id: \.self) {
                    CommentView(comment: viewModel.comment(index: $0))
                }
            }
        }.padding(10)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(viewModel: .init(comments: []))
    }
}

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var value: String
    var subItems: [Item]?
}
