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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setShadows()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
            onboardingView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(onboardingView)
    }
    
    private func setupConstraints() {
       
        
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    private func setShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    
    }
    
    func configure(_ onboardingItem: OnboardingItem) {
        onboardingView.image = UIImage(named: onboardingItem.imageName)
    }
}

