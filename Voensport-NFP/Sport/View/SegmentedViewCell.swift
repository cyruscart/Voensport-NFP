//
//  SegmentedViewCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 20.12.2021.
//

import UIKit

class SegmentedViewCell: UITableViewCell {
    static let identifier = "SwitchView"
    
    private var sportSegmented = UISegmentedControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        sportSegmented.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sportSegmented)
        
        NSLayoutConstraint.activate([
            sportSegmented.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            sportSegmented.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sportSegmented.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sportSegmented.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            
        ])
    }
    
    func configureCell() {
        
    }
    
}
