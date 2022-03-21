//
//  User.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 21/03/22.
//

import Foundation

struct User: Decodable {
    var id: Int
    var email, firstName, lastName: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }

    init(id: Int, email: String, firstName: String, lastName: String, avatar: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
}
