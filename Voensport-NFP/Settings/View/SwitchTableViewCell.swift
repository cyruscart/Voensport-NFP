//
//  SwitchTableViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 05.12.2021.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "HapticTableViewCell"
   
    var switchStatement = UISwitch()
    var settingNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCell() {
        [switchStatement, settingNameLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            settingNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            settingNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            settingNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            switchStatement.leadingAnchor.constraint(equalTo: settingNameLabel.trailingAnchor, constant: 10),
            switchStatement.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            switchStatement.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            switchStatement.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
}
