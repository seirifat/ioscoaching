//
//  HomeViewController.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 14/03/22.
//

import UIKit

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
    private lazy var textFieldValue = UITextField()
    
    // Properties
    private var titleString: String? = nil
    
    // 2. buat delegate / orang perantara
    var delegate: HomeViewControllerDelegate?
    
    // MARK: OVERRIDES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: METHODS
    
    convenience init(titleString: String?) {
        self.init()
        
        self.titleString = titleString
    }
    
    private func setupViews() {
        view.backgroundColor = .yellow
        
        setupCloseButton()
        setupStackView()
        setupLabel()
        setupTextViewName()
        setupSaveButton()
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
//        let stringValue = textFieldValue.text
//        if stringValue == nil {
//            let alert = UIAlertController(title: "Error", message: "Teks tidak boleh kosong", preferredStyle: .alert)
//            present(alert, animated: true, completion: nil)
//            return
//        }
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

}
