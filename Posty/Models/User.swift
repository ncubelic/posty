//
//  User.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String?
    let website: String?
    let company: Company?
}

extension User {
    
    init() {
        self.id = 0
        self.name = ""
        self.username = ""
        self.email = ""
        self.address = .init(street: nil, suite: nil, city: nil, zipcode: nil, geo: nil)
        self.phone = nil
        self.website = nil
        self.company = nil
    }
}
