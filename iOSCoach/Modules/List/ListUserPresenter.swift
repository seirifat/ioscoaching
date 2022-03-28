//
//  ListUserPresenter.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 21/03/22.
//

import Foundation
import Alamofire
import RealmSwift

protocol ListUserPresenterToViewProtocol {
    func showData()
    func showError(error: String)
}

class ListUserPresenter {
    var view: ListUserPresenterToViewProtocol?
    var page = 0
    var data = [User]()
    var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func loadData() {
        let result = realm.objects(User.self)
        var listData = [User]()
        if result.count > 0 {
            for dataRealm in result {
                let item = User(value: dataRealm)
                listData.append(item)
            }
        }
        data.removeAll()
        data.append(contentsOf: listData)
    }
    
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
        AF.request(
            "https://reqres.in/api/users",
            method: .get,
            parameters: parameters
        ).responseDecodable(of: PageData.self) { response in
            // Cek error
            if response.error != nil {
                print("ERROR Response: \(response.error)")
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
            
            // insert ke dalam array
            self.data.append(contentsOf: pageData.data)
            
            // Save ke cache
            try! self.realm.write {
                self.realm.add(self.data, update: .modified)
            }
            
            // Show ke View
            self.view?.showData()
        }
    }
    
}
