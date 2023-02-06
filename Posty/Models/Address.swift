//
//  Address.swift
//  Posty
//
//  Created by Nikola Čubelić on 06.02.2023..
//

import Foundation

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}
