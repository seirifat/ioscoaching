//
//  ListUsersCell.swift
//  iOSCoach
//
//  Created by Rifat Firdaus on 18/03/22.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    private lazy var stackViewMain = UIStackView()
    private lazy var labelTitle = UILabel()
    private lazy var labelPoint = UILabel()
    
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
        self.backgroundColor = .yellow
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
        
        stackViewMain.addArrangedSubview(labelTitle)
        stackViewMain.addArrangedSubview(labelPoint)
        
        labelTitle.text = "Selamat Datang Dika"
        labelPoint.text = "8.167 point"
        labelPoint.textAlignment = .right
    }
    
}
