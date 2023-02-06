//
//  PostController.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import SwiftUI
import UIKit

class PostController: UIViewController {
    
    private let service = Service()
    
    private lazy var postsViewController: PostsViewController = {
        let vc = PostsViewController()
        vc.delegate = self
        return vc
    }()
    
    private var users: [User] = []
    private var comments: [Comment] = []
    
    override func loadView() {
        view = UIView()
        
        loadPosts()
        loadUsers()
        loadComments()
        install(postsViewController)
    }
    
    private func loadPosts() {
        service.loadPosts { [postsViewController] result in
            switch result {
            case .success(let posts):
                postsViewController.update(posts: posts)
            case .failure(let errorReport):
                print("Error occurred while loading posts: \(errorReport.localizedDescription)")
            }
        }
    }
    
    private func loadUsers() {
        service.loadUsers { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let errorReport):
                print("Error occurred while loading users: \(errorReport.localizedDescription)")
            }
        }
    }
    
    private func loadComments() {
        service.loadComments { result in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let errorReport):
                print("Error occurred while loading comments: \(errorReport.localizedDescription)")
            }
        }
    }
    
    override var navigationItem: UINavigationItem {
        postsViewController.navigationItem
    }
}

extension PostController: PostsViewControllerDelegate {
    
    func postsViewController(_ viewController: PostsViewController, didSelect post: Post) {
        guard let postAuthor = users.first(where: { $0.id == post.userId }) else { return }
        let postComments = comments.filter { $0.postId == post.id }
        let postViewModel = PostViewModel(post: post, author: postAuthor, comments: postComments)
        
        
        let postDetailsView = PostDetailsView(viewModel: postViewModel)
        let hostingController = UIHostingController(rootView: postDetailsView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
