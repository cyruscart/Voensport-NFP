//
//  OnBoardingFooter.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import UIKit

class OnBoardingFooter: UICollectionReusableView {
    static let identifier = "OnBoardingFooter"
   
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var nextButton: UIButton = {
        let button = UIButton.createSaveButton()
        button.setTitle("Далее", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            addSubview(nextButton)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
       
        NSLayoutConstraint.activate([
            
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            
        ])
    }
    
    func configure(_ onboardingItem: OnboardingItem) {
        messageLabel.text = onboardingItem.message
    }
}


