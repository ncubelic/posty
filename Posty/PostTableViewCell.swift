//
//  PostTableViewCell.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private lazy var letterView = configure(UIView()) {
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 10
        $0.layer.cornerCurve = .continuous
    }
    
    private lazy var letterLabel = configure(UILabel()) {
        $0.font = .preferredFont(forTextStyle: .largeTitle)
    }
    
    private lazy var postTitleLabel = configure(UILabel()) {
        $0.numberOfLines = 0
        $0.font = .preferredFont(forTextStyle: .title2)
    }
    
    private lazy var postDescriptionLabel = configure(UILabel()) {
        $0.numberOfLines = 3
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    private lazy var stack = configure(UIStackView()) {
        $0.axis = .vertical
        $0.spacing = 10
        $0.addArrangedSubview(postTitleLabel)
        $0.addArrangedSubview(postDescriptionLabel)
    }
    
    private var designColors: [UIColor] {
        [.systemGray, .systemRed, .systemBlue, .systemOrange, .systemYellow, .systemGreen]
    }
    
    private var randomDesignColor: UIColor {
        designColors[Int.random(in: 0..<(designColors.count - 1))]
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String?, subtitle: String?) {
        postTitleLabel.text = title
        postDescriptionLabel.text = subtitle
        
        letterView.backgroundColor = randomDesignColor
        letterLabel.text = title?.first?.uppercased()
    }
    
    private func setupViews() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(stack)
        contentView.addSubview(letterView)
        letterView.addSubview(letterLabel)
        
        letterView.layout(using: [
            letterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            letterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            letterView.widthAnchor.constraint(equalToConstant: 50),
            letterView.heightAnchor.constraint(equalToConstant: 50)
        ])
        letterLabel.layout(using: [
            letterLabel.centerXAnchor.constraint(equalTo: letterView.centerXAnchor),
            letterLabel.centerYAnchor.constraint(equalTo: letterView.centerYAnchor)
        ])
        stack.layout(using: [
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: letterView.trailingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

// It's a good approach to move cell setup functions outside the cell itself if it uses custom models (from the same file also).
// For example, if you build a scallable app which contains few targets or internal first party frameworks, then you can reuse
// a cell accross the frameworks.
extension PostTableViewCell {
    
    func setup(post: Post) {
        setup(title: post.title, subtitle: post.body)
    }
}
