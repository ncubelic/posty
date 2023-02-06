//
//  UIView+Layout.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import UIKit

extension UIView {
    
    func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

/// Global helper function for use anywhere
func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}
