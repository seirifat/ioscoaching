//
//  ListUsersViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 18/03/22.
//

import UIKit

class ListUsersViewController: UIViewController {

    private lazy var tableViewUsers = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .green
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewUsers.delegate = self
        tableViewUsers.dataSource = self
        tableViewUsers.separatorStyle = .singleLine
        tableViewUsers.register(ListUsersCell.self, forCellReuseIdentifier: "ListUsersCell")
        tableViewUsers.register(ListUsersRightCell.self, forCellReuseIdentifier: "ListUsersRightCell")
        tableViewUsers.register(UserInfoCell.self, forCellReuseIdentifier: "UserInfoCell")
//        tableViewUsers.estimatedRowHeight = 100
        tableViewUsers.rowHeight = UITableView.automaticDimension
        view.addSubview(tableViewUsers)
        tableViewUsers.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewUsers.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 0
            ),
            tableViewUsers.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0
            ),
            tableViewUsers.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: 0
            ),
            tableViewUsers.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0
            ),
        ])
    }
}

extension ListUsersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as! UserInfoCell
            return cell
        } else {
            if indexPath.row > 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ListUsersRightCell", for: indexPath) as! ListUsersRightCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListUsersCell", for: indexPath) as! ListUsersCell
            return cell
        }
    }
    
}

extension ListUsersViewController: UITableViewDelegate {
    //
}
