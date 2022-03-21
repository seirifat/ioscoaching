//
//  ListUserPresenter.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 21/03/22.
//

import Foundation
import Alamofire

protocol ListUserPresenterToViewProtocol {
    func showData()
    func showError(error: String)
}

class ListUserPresenter {
    var view: ListUserPresenterToViewProtocol?
    var page = 0
    var data = [User]()
    
    func refresh() {
        page = 0
        nextPage()
    }
    
    func nextPage() {
        page += 1
        let parameters = [
            "page": page,
            "per_page": 10
        ]
        AF.request("https://reqres.in/api/users",
                   method: .get,
                   parameters: parameters)
            .responseDecodable(of: PageData.self) { response in
                if response.error != nil {
                    print("ERROR Response: \(response.error)")
                    self.view?.showError(error: response.error?.localizedDescription ?? "Something went wrong! Please try again!")
                    return
                }
                guard let pageData = response.value else {
                    self.view?.showError(error: "Something went wrong! Please try again!")
                    return
                }
                self.data = pageData.data
                self.view?.showData()
            }
    }
    
}
