//
//  LoginViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 11/03/22.
//

import UIKit

// 5. Implement protocol
class LoginViewController: UIViewController {
    
    // Definisi view
    lazy var labelTest = UILabel()
    lazy var buttonTest = UIButton(type: .system)
    lazy var stackViewMain = UIStackView()
    lazy var imageViewBg = UIImageView()
    lazy var textFieldName = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        
    }
    
    func setupViews() {
        view.backgroundColor = .red
        
        setupImageBg()
        setupStackView()
        setupLabel()
        setupTextViewName()
        setupButton()
        keyboarHandling()
    }
    
    func keyboarHandling() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupStackView() {
        stackViewMain.axis = .vertical
        stackViewMain.alignment = .center
        stackViewMain.spacing = 16
        
        view.addSubview(stackViewMain)
        stackViewMain.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewMain.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackViewMain.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackViewMain.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    func setupLabel() {
        labelTest.text = "Test iOS Coach"
        labelTest.textColor = .white
        labelTest.textAlignment = .center
        labelTest.backgroundColor = .black
        
        stackViewMain.addArrangedSubview(labelTest)
    }
    
    func setupTextViewName() {
        textFieldName.placeholder = "Insert your name"
        textFieldName.autocorrectionType = .no
        stackViewMain.addArrangedSubview(textFieldName)
    }
    
    func setupButton() {
        buttonTest.setTitle("Login", for: .normal)
        buttonTest.setTitleColor(.white, for: .normal)
        buttonTest.backgroundColor = .blue
        buttonTest.widthAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.width / 3).isActive = true
        stackViewMain.addArrangedSubview(buttonTest)
        buttonTest.addTarget(
            self,
            action: #selector(showHomeViewController),
            for: .touchUpInside)
    }
    
    func setupImageBg() {
        imageViewBg.image = UIImage(named: "bg_home")
        
        view.addSubview(imageViewBg)
        imageViewBg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewBg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewBg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewBg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    // MARK: OBJCS
    
    @objc func showHomeViewController() {
        let textFieldNameString = textFieldName.text
        let controller = HomeViewController.instantiate(delegate: self, title: textFieldNameString ?? "-")
        present(controller, animated: true, completion: nil)
    }
    
}
// END LoginViewController


extension LoginViewController: HomeViewControllerDelegate {
    // 5. Jalankan fungsi
    func saveValue(value: String) {
        labelTest.text = value
    }
}
