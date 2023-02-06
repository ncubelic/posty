//
//  AppController.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import UIKit

class AppController: UIViewController {
    
    private let rootViewController = UINavigationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for this purpose show Home screen, but in the real app check whether show the login screen
        // or home screen
        showHome()
    }
    
    private func showHome() {
        let postController = PostController()
        rootViewController.setViewControllers([postController], animated: false)
        install(rootViewController)
    }
    
    private func showLogin() { }
}
