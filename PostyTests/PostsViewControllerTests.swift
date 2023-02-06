//
//  PostsViewControllerTests.swift
//  PostyTests
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import XCTest

final class PostsViewControllerTests: XCTestCase {

    var actionPerformed = false
    
    func testThatTapOnPostNotifiesDelegate() {
        let postsViewController = PostsViewController()
        _ = postsViewController.view
        
        postsViewController.update(posts: .mockData)
        postsViewController.delegate = self
        
        let selectingIndexPath = IndexPath(row: 0, section: 0)
        postsViewController.tableView.delegate?.tableView?(postsViewController.tableView, didSelectRowAt: selectingIndexPath)
        XCTAssertTrue(actionPerformed)
    }
    
    func testThatUpdateFunctionReloadsDataSource() {
        let postsViewController = PostsViewController()
        _ = postsViewController.view
        
        let before = postsViewController.tableView.dataSource?.tableView(postsViewController.tableView, numberOfRowsInSection: 0)
        XCTAssertNotEqual(before, [Post].mockData.count)
        
        postsViewController.update(posts: .mockData)
        
        let after = postsViewController.tableView.dataSource?.tableView(postsViewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(after, [Post].mockData.count)
    }
}

extension PostsViewControllerTests: PostsViewControllerDelegate {
    
    func postsViewController(_ viewController: PostsViewController, didSelect post: Post) {
        actionPerformed = true
    }
}
