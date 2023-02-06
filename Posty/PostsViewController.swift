//
//  PostsViewController.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import UIKit

protocol PostsViewControllerDelegate: AnyObject {
    func postsViewController(_ viewController: PostsViewController, didSelect post: Post)
}

class PostsViewController: UIViewController {
    
    lazy var tableView = configure(UITableView(frame: .zero, style: .plain)) {
        $0.dataSource = self
        $0.delegate = self
        $0.registerCell(ofType: PostTableViewCell.self)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 44
    }
    
    weak var delegate: PostsViewControllerDelegate?
    
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupViews()
    }
    
    func update(posts: [Post]) {
        self.posts = posts
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        
        tableView.layout(using: [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PostTableViewCell.self, for: indexPath)
        cell.setup(post: posts[indexPath.row])
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.postsViewController(self, didSelect: posts[indexPath.row])
    }
}
