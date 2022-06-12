//
//  ProductsPresenter.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 29/03/22.
//

import Foundation
import Alamofire
import RealmSwift

protocol ListProductPresenterToViewProtocol {
    func showData()
    func showError(error: String)
}

class ListProductPresenter {
    var view: ListProductPresenterToViewProtocol?
    var page = 0
    var data = [Product]()
    
    func refresh() {
        page = 0
        nextPage()
    }
    
    func nextPage() {
        page += 1
        let parameters = [
            "page": page,
            "per_page": 6
        ]
        AF.request(
            "https://reqres.in/api/users",
            method: .get,
            parameters: parameters
        ).responseDecodable(of: PageDataProduct.self) { response in
            // Cek error
            if response.error != nil {
                print("ERROR Response: \(String(describing: response.error))")
                self.view?.showError(
                    error: response.error?.localizedDescription
                    ?? "Something went wrong! Please try again!"
                )
                return
            }
            //cek data. ada atw nggak
            guard let pageData = response.value else {
                self.view?.showError(error: "Something went wrong! Please try again!")
                return
            }
            // cek halaman pertama
            if self.page == 1 {
                self.data.removeAll()
            }
            if let product = pageData.data {
                self.data.append(contentsOf: product)
            }
            // Show ke View
            self.view?.showData()
        }
    }
    
}
