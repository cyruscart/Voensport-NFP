//
//  OnbordingCell.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    static let identifier = "OnbordingCell"
    
    private let onboardingView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        setSubviews(on: contentView, onboardingView)
        setViewShadows()
        
        NSLayoutConstraint.activate([
            onboardingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(_ onboardingItem: OnboardingItem) {
        onboardingView.image = UIImage(named: onboardingItem.imageName)
    }
    
}
