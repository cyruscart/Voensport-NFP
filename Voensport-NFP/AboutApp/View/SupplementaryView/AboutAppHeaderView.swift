//
//  AboutAppHeaderView.swift
//  Voensport-NFP
//
//  Created by Кирилл on 28.12.2021.
//

import UIKit

final class AboutAppHeaderView: UICollectionReusableView {
    static let identifier = "AboutAppHeaderView"
   
    let headLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        setSubviews(on: self, headLabel, messageLabel )
        
        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: topAnchor),
            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
  
}

