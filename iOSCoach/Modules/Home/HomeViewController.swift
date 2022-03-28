//
//  HomeViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 14/03/22.
//

import UIKit
import AlamofireImage

// 1. buat protocol
protocol HomeViewControllerDelegate {
    func saveValue(value: String)
}

class HomeViewController: UIViewController {
    
    // Views
    private lazy var stackViewMain = UIStackView()
    private lazy var labelTitle = UILabel()
    private lazy var buttonClose = UIButton(type: .system)
    private lazy var buttonSave = UIButton(type: .system)
    private lazy var buttonList = UIButton(type: .system)
    private lazy var textFieldValue = UITextField()
    private lazy var imageUser = UIImageView()
    
    // Properties
    private var titleString: String? = nil
    
    // 2. buat delegate / orang perantara
    var delegate: HomeViewControllerDelegate?
    
    static func instantiate(delegate: HomeViewControllerDelegate?, title: String) -> UINavigationController {
        let controller = HomeViewController(titleString: title)
        // 4. konekin delegate
        controller.delegate = delegate
        let nav = UINavigationController(rootViewController: controller)
        controller.title = "Home"
        nav.modalPresentationStyle = .fullScreen
        return nav
    }
    
    // MARK: OVERRIDES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate=nil
        setupViews()
    }
    
    // MARK: METHODS
    
    convenience init(titleString: String?) {
        self.init()
        
        self.titleString = titleString
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
//        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = .orange
//        self.navigationController?.navigationBar.tintColor = .red
        
        setupCloseButton()
        setupStackView()
        setupLabel()
        setupTextViewName()
        setupSaveButton()
        setupListButton()
        setupImageView()
    }
    
    private func setupImageView() {
        imageUser.translatesAutoresizingMaskIntoConstraints = false
        
        let imageWidth = UIScreen.main.bounds.width / 3
        
        let imageUserWidthAnchor = imageUser.heightAnchor.constraint(equalToConstant: imageWidth)
        imageUserWidthAnchor.priority = UILayoutPriority(rawValue: 999)
        imageUserWidthAnchor.isActive = true
        imageUser.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        imageUser.layer.cornerRadius = imageWidth / 2
        
        stackViewMain.addArrangedSubview(imageUser)
        imageUser.image = UIImage(named: "ic_user")
        imageUser.clipsToBounds = true
        imageUser.contentMode = .scaleAspectFill
    }
    
    private func setupTextViewName() {
        textFieldValue.placeholder = "Insert Value"
        textFieldValue.autocorrectionType = .no
        stackViewMain.addArrangedSubview(textFieldValue)
    }
    
    private func setupSaveButton() {
        
        // Attributers
        buttonSave.setTitle("SAVE", for: .normal)
        buttonSave.setTitleColor(.white, for: .normal)
        buttonSave.addTarget(
            self,
            action: #selector(saveValue),
            for: .touchUpInside
        )
        buttonSave.backgroundColor = .blue
        
        // Constraints
        stackViewMain.addArrangedSubview(buttonSave)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.widthAnchor.constraint(equalToConstant: 120).isActive = true
        buttonSave.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupListButton() {
        
        // Attributers
        buttonList.setTitle("List", for: .normal)
        buttonList.setTitleColor(.white, for: .normal)
        buttonList.addTarget(
            self,
            action: #selector(showList),
            for: .touchUpInside
        )
        buttonList.backgroundColor = .green
        
        // Constraints
        stackViewMain.addArrangedSubview(buttonList)
        buttonList.translatesAutoresizingMaskIntoConstraints = false
        buttonList.widthAnchor.constraint(equalToConstant: 120).isActive = true
        buttonList.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupCloseButton() {
        
        // Attributers
        buttonClose.setTitle("Close", for: .normal)
        buttonClose.setTitleColor(.black, for: .normal)
        buttonClose.addTarget(
            self,
            action: #selector(closeViewController),
            for: .touchUpInside
        )
//        buttonClose.backgroundColor = .red
        
        // Constraints
        view.addSubview(buttonClose)
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        
//        buttonClose.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        buttonClose.heightAnchor.constraint(equalToConstant: 44).isActive = true
        NSLayoutConstraint.activate([
            buttonClose.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 16),
            buttonClose.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    private func setupStackView() {
        stackViewMain.axis = .vertical
        stackViewMain.alignment = .center
        stackViewMain.spacing = 16

        view.addSubview(stackViewMain)
        stackViewMain.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackViewMain.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupLabel() {
        labelTitle.text = titleString ?? "-"
        labelTitle.font = UIFont.systemFont(ofSize: 42)
        labelTitle.textColor = .black
        labelTitle.textAlignment = .center
        
        stackViewMain.addArrangedSubview(labelTitle)
    }
    
    @objc func closeViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveValue() {
        guard let stringValue = textFieldValue.text, stringValue != "" else {
            let alert = UIAlertController(
                title: "Error",
                message: "Teks tidak boleh kosong",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: "OK", style: .destructive, handler: nil)
            )
            present(alert, animated: true, completion: nil)
            return
        }
        // 3. Panggil fungsi delegate
        delegate?.saveValue(value: stringValue)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showList() {
        let controller = ListUsersViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
//    @objc func showProductLst() {
//        let controller = ListProductViewController()
//        controller.delegate = self
//        navigationController?.pushViewController(controller, animated: true)
//    }

}

extension HomeViewController: ListUsersViewControllerDelegate {
    func setUser(user: User) {
        if let urlString = user.avatar, let url = URL(string: urlString) {
            imageUser.af.setImage(withURL: url)
        }
    }
}

