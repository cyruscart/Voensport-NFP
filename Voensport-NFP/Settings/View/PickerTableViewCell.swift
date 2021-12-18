//
//  PickerTableViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 18.12.2021.
//

import UIKit

class PickerTableViewCell: UITableViewCell {
    
    static let identifier = "PickerTableViewCell"
    
    
     var pickerTextField: UITextField = {
        let tf = UITextField()
       
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupCell() {
        pickerTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pickerTextField)
        
        NSLayoutConstraint.activate([
            pickerTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pickerTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pickerTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pickerTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ])
    }
    
    func configure(settings: Settings) {
        if settings.tariff != 0 {
            pickerTextField.text = "\(settings.tariff) тарифный разряд"
        }
    }
    
    
}
