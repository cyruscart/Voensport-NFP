//
//  OnbordingCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnbordingCell"
    private var onboardingView = UIImageView()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupCell()
        setShadows()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [onboardingView, messageLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        let height = UIScreen.main.bounds.height / 1.5
        
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            onboardingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            onboardingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            onboardingView.heightAnchor.constraint(equalToConstant: height),
            
            messageLabel.topAnchor.constraint(equalTo: onboardingView.bottomAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    private func setShadows() {
        onboardingView.layer.masksToBounds = true
        onboardingView.layer.cornerRadius = 15
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
    
    func configure(_ onboardingItem: OnboardingItem) {
        onboardingView.image = UIImage(named: onboardingItem.imageName)
        messageLabel.text = onboardingItem.message
    
      
    }
}

