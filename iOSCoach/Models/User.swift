//
//  User.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 21/03/22.
//

import Foundation
import Unrealm
import RealmSwift

class User: Object, Decodable {
    @objc var id: Int = 0
    @objc var email, firstName, lastName: String?
    @objc var avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
