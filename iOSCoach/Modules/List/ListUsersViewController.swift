//
//  ListUsersViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 18/03/22.
//

import UIKit

protocol ListUsersViewControllerDelegate {
    func setUser(user: User)
}

class ListUsersViewController: UIViewController {

    private lazy var tableViewUsers = UITableView()
    private let presenter = ListUserPresenter()
    var delegate: ListUsersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.view = self
//        presenter.loadData()
        tableViewUsers.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.refresh()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count // length
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListUsersCell", for: indexPath) as! ListUsersCell
        cell.setData(user: presenter.data[indexPath.row])
        return cell
    }
    
}

extension ListUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = presenter.data[indexPath.row]
        delegate?.setUser(user: user)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ListUsersViewController: ListUserPresenterToViewProtocol {
    func showData() {
        tableViewUsers.reloadData()
    }
    
    func showError(error: String) {
        print(error)
        let alert = UIAlertController(
            title: "Error",
            message: "Terjadi kesalahan, ulangi",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: .destructive, handler: nil)
        )
        present(alert, animated: true, completion: nil)
    }
}
