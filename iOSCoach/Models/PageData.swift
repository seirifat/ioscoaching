//
//  PageData.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 21/03/22.
//

import Foundation

struct PageData: Decodable {
    var page, per_page, total, total_pages: Int
    var data: [User]
    
    init(page: Int, perPage: Int, total: Int, totalPages: Int, data: [User]) {
        self.page = page
        self.per_page = perPage
        self.total = total
        self.total_pages = totalPages
        self.data = data
    }
}
