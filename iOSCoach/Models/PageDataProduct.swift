//
//  PageDataProduct.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 29/03/22.
//

import Foundation

// MARK: - PageDataProduct
struct PageDataProduct: Decodable {
    var page, perPage, total, totalPages: Int?
    var data: [Product]?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
}
