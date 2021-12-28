//
//  HeaderView.swift
//  Voensport-NFP
//
//  Created by Кирилл on 15.12.2021.
//

import UIKit

class NfpExerciseHeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let inset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset)
        ])
    }
}

