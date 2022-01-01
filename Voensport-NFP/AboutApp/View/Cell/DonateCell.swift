//
//  DonateCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 28.12.2021.
//

import UIKit

final class DonateCell: UICollectionViewCell  {
    static let identifier = "DonateCell"
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let smallDonateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.blue
        button.setTitle("99 \u{20BD}", for: .normal)
        return button
    }()
    
    private var mediumDonateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.blue
        button.setTitle("199 \u{20BD}", for: .normal)
        return button
    }()
    
    private var largeDonateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.blue
        button.setTitle("499 \u{20BD}", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.masksToBounds = false
        setViewShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        configureStackView()
        
        [messageLabel, buttonStackView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func configureStackView() {
        var size = CGFloat(UIScreen.main.bounds.width / 7)
        [smallDonateButton, mediumDonateButton, largeDonateButton].forEach { button in
            buttonStackView.addArrangedSubview(button)
            
            button.widthAnchor.constraint(equalToConstant: size).isActive = true
            button.heightAnchor.constraint(equalToConstant: size).isActive = true
            button.layer.cornerRadius = size / 2
            button.setViewShadows()
            
            size *= 1.3
        }
    }
    
}
