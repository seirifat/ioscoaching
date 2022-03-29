//
//  Product.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 29/03/22.
//

import Foundation

// MARK: - Datum
struct Product: Decodable {
    var id: Int
    var email, firstName, lastName: String?
    var avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
