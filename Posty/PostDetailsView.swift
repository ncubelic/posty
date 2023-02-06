//
//  PostDetailsView.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import SwiftUI

struct PostDetailsView: View {
    
    private let viewModel: PostViewModel
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(viewModel.post?.title ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack(alignment: .center, spacing: 5) {
                Text("Author")
                    .font(.footnote)
                Text(viewModel.author?.name ?? "")
                    .font(.footnote)
                    .fontWeight(.bold)
                Text("Comments")
                    .padding(.leading, 10)
                    .font(.footnote)
                Text("\(viewModel.comments.count)")
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            Text(viewModel.post?.body ?? "")
                .font(.body)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(viewModel: .init(post: nil, author: nil, comments: []))
    }
}
