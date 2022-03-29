//
//  ProductCell.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 29/03/22.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    lazy private var labelName = UILabel()
    lazy private var labelPrice = UILabel()
    lazy private var imageViewProduct = UIImageView()
    lazy private var stackViewMain = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupData(product: Product) {
        labelName.text = product.firstName
        labelPrice.text = product.email
        if let urlString = product.avatar, let url = URL(string: urlString) {
            imageViewProduct.af.setImage(withURL: url)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let randomColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
        self.backgroundColor = randomColor
        setupStackView()
        setupImageView()
        setupLabel()
    }
    
    private func setupStackView() {
        self.addSubview(stackViewMain)
        stackViewMain.axis = .vertical
        stackViewMain.translatesAutoresizingMaskIntoConstraints = false
        //StackView MArgin
        stackViewMain.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackViewMain.isLayoutMarginsRelativeArrangement = true
        stackViewMain.spacing = 8
        NSLayoutConstraint.activate([
            stackViewMain.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 0
            ),
            stackViewMain.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0
            ),
            stackViewMain.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: 0
            ),
            stackViewMain.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0
            ),
        ])
    }
    
    private func setupImageView() {
        imageViewProduct.translatesAutoresizingMaskIntoConstraints = false
        imageViewProduct.contentMode = .scaleAspectFill
        imageViewProduct.clipsToBounds = true
        stackViewMain.addArrangedSubview(imageViewProduct)
    }
    
    private func setupLabel() {
        self.addSubview(labelName)
        labelName.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        labelName.textColor = .white
        labelName.setContentHuggingPriority(.defaultHigh, for: .vertical)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        stackViewMain.addArrangedSubview(labelName)
        
        self.addSubview(labelPrice)
        labelPrice.font = UIFont.systemFont(ofSize: 16)
        labelPrice.textColor = .white
        labelPrice.setContentHuggingPriority(.defaultHigh, for: .vertical)
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        stackViewMain.addArrangedSubview(labelPrice)
    }
    
}
