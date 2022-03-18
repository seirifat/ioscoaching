//
//  ListUsersCell.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 18/03/22.
//

import UIKit

class ListUsersRightCell: UITableViewCell {
    
    private lazy var stackViewMain = UIStackView()
    private lazy var labelTitle = UILabel()
    private lazy var imageUser = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(stackViewMain)
        stackViewMain.axis = .horizontal
        stackViewMain.spacing = 16
        stackViewMain.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewMain.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 16
            ),
            stackViewMain.topAnchor.constraint(
                equalTo: self.topAnchor, constant: 8
            ),
            stackViewMain.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -16
            ),
            stackViewMain.bottomAnchor.constraint(
                equalTo: self.bottomAnchor, constant: -8
            ),
        ])
        
        imageUser.translatesAutoresizingMaskIntoConstraints = false
        imageUser.widthAnchor.constraint(equalToConstant: 64).isActive = true
        let imageUserWidthAnchor = imageUser.heightAnchor.constraint(equalToConstant: 64)
        imageUserWidthAnchor.priority = UILayoutPriority(rawValue: 999)
        imageUserWidthAnchor.isActive = true
        imageUser.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        stackViewMain.addArrangedSubview(labelTitle)
        stackViewMain.addArrangedSubview(imageUser)
        
        labelTitle.text = " - "
        imageUser.image = UIImage(named: "ic_user")
        imageUser.clipsToBounds = true
    }
    
}
